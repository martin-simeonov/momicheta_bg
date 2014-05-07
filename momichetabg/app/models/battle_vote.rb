class BattleVote < ActiveRecord::Base
	belongs_to :battle
	belongs_to :user
	
	def self.delete_votes
		BattleVote.delete_all()
	end
end
