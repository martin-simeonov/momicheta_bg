class AddCheckedToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :checked, :boolean, default: false
  end
end
