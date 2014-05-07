class AddFinishedToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :finished, :boolean, default: false
  end
end
