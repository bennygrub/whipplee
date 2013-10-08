class AddDirectToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :direct, :text
  	add_column :posts, :teaser, :text
  	change_column :posts, :content, :text
  end
end
