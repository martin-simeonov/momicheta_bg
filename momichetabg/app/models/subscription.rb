class Subscription < ActiveRecord::Base
	belongs_to :user

	attr_accessible :user_id, :battle_id
end