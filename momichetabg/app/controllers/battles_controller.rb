class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]
  before_filter :access, :except => [:index, :show, :subscriptions, :picture_history, :vote, :subscribe, :unsubscribe]
  
  # GET /battles
  # GET /battles.json
  def index
    @battles = Battle.all
    set_duel()
  end

  # GET /battles/1
  # GET /battles/1.json
  def show
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles
  # POST /battles.json
  def create
    @battle = Battle.new(battle_params)

    respond_to do |format|
      if @battle.save
        format.html { redirect_to @battle, notice: 'Battle was successfully created.' }
        format.json { render action: 'show', status: :created, location: @battle }
      else
        format.html { render action: 'new' }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battles/1
  # PATCH/PUT /battles/1.json
  def update
    respond_to do |format|
      if @battle.update(battle_params)
        format.html { redirect_to @battle, notice: 'Battle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1
  # DELETE /battles/1.json
  def destroy
    @battle.destroy
    respond_to do |format|
      format.html { redirect_to battles_url }
      format.json { head :no_content }
    end
  end

  def ready_images
    if Tournament.find_by_state(1)
      Picture.where(tournament_id: Tournament.find_by_state(1).id).where(checked: true).where(in_battle: false)

    end
  end 

  def admin
    if Tournament.find_by_state(2)
      @total_images = Picture.where(tournament_id: Tournament.find_by_state(2).id).where(checked: true).where(in_battle: true).count
    else 
       @total_images = 0 
    end
    if ready_images()
      @number_of_ready_images = ready_images().count
    else
      @number_of_ready_images = 0
    end  
  end

  def get_winners
    winners = Array.new

    Battle.where(finished: false).each do |b|
      winners << Picture.find(b.winner)
    end

    winners
  end

  def subscriptions 
    @sub = Subscription.find_all_by_user_id(current_user.id)
  end

  def unsubscribe
    s = current_user.subscriptions.find_by_battle_id(params[:battle_id])
    s.delete
    @duel = Battle.find(params[:battle_id])

    respond_to do |format|
      format.js { render action: "bookmark" }
    end
  end

  def subscribe
    unless current_user.subscriptions.map(&:battle_id).include?(params[:battle_id].to_i)
      Subscription.create(user_id: current_user.id, battle_id: params[:battle_id])
    end
    @duel = Battle.find(params[:battle_id])
    
    respond_to do |format|
      format.js { render action: "bookmark" }
    end
  end

  def picture_history
    if not Picture.find(params[:id]).nil?
      if current_user.pictures.include?(Picture.find(params[:id]))
        @battles = Battle.find_all_by_oponent1_id(params[:id]) + Battle.find_all_by_oponent2_id(params[:id])
        @battles.sort_by {|obj| obj.created_at }.reverse!
      end
      #redirect_to root_path
    end
  end

  def start_tournament
    arr = ready_images()
    t = Tournament.find_by_state(1)

    tournament_step(t,arr)
    t = Tournament.create(state: 1, start_time: Time.now.utc)

    redirect_to battles_admin_path
  end

  def move_tournament
    arr = get_winners()
    t = Tournament.find_by_state(2)

    if arr.count > 1
      tournament_step(t,arr)
    else 
      t.winner_id = get_winners().first.id
      t.state = 3
      t.save

      Battle.where(tournament_id: t.id).where(finished: false).each do |b|
        b.finished = true
        b.save
      end
    end  

    redirect_to battles_admin_path
  end  

  

  def tournament_step(tournament,pics)
    arr = pics
    t = tournament

    unless t.nil?
      Battle.where(tournament_id: t.id).where(finished: false).each do |b|
        b.finished = true
        b.save
      end

      for i in 1..(arr.count/2)
        b = Battle.new
    
        p = arr.shuffle.sample
        b.oponent1_id = p.id
        p.in_battle = true
        p.save

        arr = arr.reject { |a| a == p}
    
        p = arr.shuffle.sample
        b.oponent2_id = p.id
        p.in_battle = true
        p.save

        arr = arr.reject { |a| a == p}

        b.tournament = t
        t.state = 2
        t.save

        b.save
      end    
    end
  end

  


  def vote
    b = Battle.find(params[:battle_id])
    ip = request.remote_ip
    has_user = b.battle_votes.map(&:user).include?(current_user)
    has_ip = b.battle_votes.map(&:voter_ip).include?(ip)

    if (!current_user.nil? and !has_user and !has_ip) or (!current_user.nil? and !has_user and has_ip) or (current_user.nil? and !has_ip)
        v = BattleVote.new
        v.voter_ip = ip
        v.battle = b
        v.choice = params[:choice]
        if current_user
          v.user = current_user 
        end 
        v.save

        b = Battle.find(params[:battle_id].to_i)
        if params[:choice].to_i == 1
          b.oponent1_votes += 1
        elsif params[:choice].to_i == 2
          b.oponent2_votes += 1
        end

        b.save
    end    

    @last_duel = b
    set_duel()

    respond_to do |format|
      format.html { redirect_to battles_url }
      format.js { render action: "battle" }
    end
      

  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    def set_duel
      @ip = request.remote_ip
      if current_user
        @duel = Battle.where(finished: false).reject {|b| b.battle_votes.map(&:user).include?(current_user) }
      else
        @duel = Battle.where(finished: false).reject {|b| b.battle_votes.map(&:voter_ip).include?(@ip) }
      end  
      @duel = @duel.shuffle.sample
     
      if @duel.nil?
        if @last_duel.nil?
          @duel = Battle.where(finished: false).first
        else
          @duel = @last_duel.next
        end  
      end  

      unless @duel.nil?
        if current_user and @duel.battle_votes.map(&:user).include?(current_user)
            @choice = BattleVote.where(battle_id: @duel.id).where(user_id: current_user.id).first.choice    
        elsif !current_user and @duel.battle_votes.map(&:voter_ip).include?(@ip)
          @choice = BattleVote.where(battle_id: @duel.id).where(voter_ip: @ip).first.choice
        else
          @choice = 0 
        end 
      end  

    end  

    def access
      unless admin?
        redirect_to battles_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battle_params
      params.require(:battle).permit(:oponent1_id, :oponent2_id, :oponent1_votes, :oponent2_votes)
    end
end