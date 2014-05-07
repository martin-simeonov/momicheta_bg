class AddUserIdToBattleVotes < ActiveRecord::Migration
  def change
    add_column :battle_votes, :user_id, :integer
  end
end
