class Admin < ActiveRecord::Base

	attr_accessible :user_id, :permission
end