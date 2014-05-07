class Battle < ActiveRecord::Base
	belongs_to :oponent1 , class_name: "Picture", foreign_key: "oponent1_id"
	belongs_to :oponent2 , class_name: "Picture", foreign_key: "oponent2_id"
	belongs_to :tournament
	has_many :battle_votes

	attr_accessible :oponent1_id, :oponent2_id, :oponent1_votes, :oponent2_votes
	
	def winner
		if self.oponent1_votes > self.oponent2_votes
			self.oponent1_id
		elsif self.oponent1_votes < self.oponent2_votes
			self.oponent2_id
		else	
			decide = Random.new
        	i = decide.rand(1..2)
        	self.send("oponent#{i}_id")
		end		
	end

	def next
		last_id = Battle.last.id
  		if self.tournament.state == 2
  			tournament = self.tournament
  		else 
   			tournament = Tournament.find_by_state(2)
  		end 
  
  		start_id = self.id  
  		next_id = self.id + 1
  		b = 0 
  		unless self.nil?
   			while b.class != Battle or next_id == start_id do 
    			if next_id <= last_id
     				if Battle.exists?(id: next_id)
      					if Battle.find(next_id).tournament == tournament
       						if Battle.find(next_id).finished == false
        						b = Battle.find(next_id)
       						end 
      					end
     				end 
    			else
     				b = Battle.where(finished: false).where(tournament_id: tournament.id).first
    			end
   	 			next_id+= 1
    		end
  		end 
  		b
 	end

end


class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end