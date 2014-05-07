class Picture < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament

	after_create :set_tournament

	attr_accessible :user_id, :avatar

  has_attached_file :avatar, :styles => {:medium => "", :thumb => "100x100>"}, 
  			:default_url => "/assets/:style/missing.png", 
  			:convert_options => { :medium => "-resize 380x540^ -gravity Center -crop 380x540+0+0 +repage" }
  validates_attachment_presence :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  
  private
		def set_tournament
			t = Tournament.find_by_state(1)
			if t.start_time > Time.now
				self.tournament = t
				self.save
			end	   
		end
 
end
