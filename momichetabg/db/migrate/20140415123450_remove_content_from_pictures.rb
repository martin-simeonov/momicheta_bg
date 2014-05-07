class RemoveContentFromPictures < ActiveRecord::Migration
  def change
  	remove_column :pictures, :content
  end
end
