class Repair < ActiveRecord::Migration
  def change
  	change_column :battles, :oponent1_votes, :integer, :default => 0
  	change_column :battles, :oponent2_votes, :integer, :default => 0
  	add_column :battles, :tournament_id, :integer
  end
end
