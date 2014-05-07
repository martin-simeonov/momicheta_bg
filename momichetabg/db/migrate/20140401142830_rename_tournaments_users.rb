class RenameTournamentsUsers < ActiveRecord::Migration
  def change
  	rename_table :tournaments_users, :pictures_tournaments
  	rename_column :pictures_tournaments, :user_id, :picture_id
  end
end
