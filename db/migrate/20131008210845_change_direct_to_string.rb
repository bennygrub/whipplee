class ChangeDirectToString < ActiveRecord::Migration
  def up
  	change_column :posts, :direct, :string
  end

  def down
  	change_column :posts, :direct, :text
  end
end
