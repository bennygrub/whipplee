class AddVembedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :vembed, :text
  end
end
