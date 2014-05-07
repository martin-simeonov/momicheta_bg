class AddTournamentIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :tournament_id, :integer
  end
end
