class AddProfilePictureToUsers < ActiveRecord::Migration
  def up
  	add_attachment :users, :profile_pic
  end

  def down
  	remove_attachment :users, :profile_pic
  end
end
