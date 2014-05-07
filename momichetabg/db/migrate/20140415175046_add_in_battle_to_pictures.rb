class AddInBattleToPictures < ActiveRecord::Migration
  def change
  	add_column :pictures, :in_battle, :boolean, :default => false
  end
end
