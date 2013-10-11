class AddFavoriteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :favorite, :integer, :default => 0
  end
end
