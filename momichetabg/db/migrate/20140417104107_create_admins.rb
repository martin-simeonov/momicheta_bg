class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
    	t.integer :user_id
    	t.integer :permission
    end
  end
end
