class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :oponent1_id
      t.integer :oponent2_id
      t.integer :oponent1_votes
      t.integer :oponent2_votes

      t.timestamps
    end
  end
end
