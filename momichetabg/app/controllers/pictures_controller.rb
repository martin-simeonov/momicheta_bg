class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_filter :access, :except => [:show, :new, :create, :mypictures]
  before_filter :tournament, :only => :new
  

  # GET /pictures
  # GET /pictures.json

  def index
    @pictures = Picture.where(in_battle: false)
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user

    respond_to do |format|
      if @picture.save
        format.html { redirect_to new_picture_path, notice: 'Picture was successfully created.' }
        format.json { render action: 'show', status: :created, location: @picture }
      else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  def approve_picture
    p = Picture.find(params[:id])
    p.checked = true
    p.save

    redirect_to pictures_url
  end  

  def disapprove_picture
    p = Picture.find(params[:id])
    p.checked = false
    p.save

    redirect_to pictures_url
  end 

  def mypictures 
    @mypic = current_user.pictures.where(checked: true);
  end

  private
    def access
      unless admin?
        redirect_to new_picture_path
      end
    end

    def tournament
      if Tournament.find_by_state(1).nil?
        redirect_to root_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:user_id, :avatar, :in_battle)
    end
end
