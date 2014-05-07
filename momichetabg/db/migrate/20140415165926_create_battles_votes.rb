class CreateBattlesVotes < ActiveRecord::Migration
  def change
    create_table :battles_votes do |t|
    	t.integer :battle_id
    	t.string :voter_ip
    	t.integer :choice
    end
  end
end
