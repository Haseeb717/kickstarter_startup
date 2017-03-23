class AddPaperclipToProduct < ActiveRecord::Migration
  def change
  	add_attachment :products, :image
  	add_attachment :products, :video
  end
end
