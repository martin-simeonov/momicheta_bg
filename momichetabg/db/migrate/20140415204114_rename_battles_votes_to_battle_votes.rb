class RenameBattlesVotesToBattleVotes < ActiveRecord::Migration
  def change
  	rename_table :battles_votes, :battle_votes
  end
end
