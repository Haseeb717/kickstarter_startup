class AddPaperclipToUser < ActiveRecord::Migration
  def change
  	add_attachment :users, :image
  	add_attachment :users, :video
  end
end
