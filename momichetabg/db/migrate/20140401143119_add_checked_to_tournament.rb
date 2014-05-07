class AddCheckedToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :checked, :boolean, default: false
  end
end
