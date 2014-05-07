class CreateTournamentsUsers < ActiveRecord::Migration
  def change
    create_table :tournaments_users do |t|
      t.integer :tourtnament_id
      t.integer :user_id
    end
  end
end
