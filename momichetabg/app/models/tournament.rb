class Tournament < ActiveRecord::Base
  has_many :pictures
  has_many :battles

  attr_accessible :winner_id, :state, :start_time, :checked
end
