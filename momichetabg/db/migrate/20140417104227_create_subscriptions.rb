class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
		t.integer :battle_id
		t.integer :user_id
    end
  end
end
