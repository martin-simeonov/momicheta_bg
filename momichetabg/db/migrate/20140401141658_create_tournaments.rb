class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :winner_id
      t.integer :state
      t.datetime :start_time

      t.timestamps
    end
  end
end
