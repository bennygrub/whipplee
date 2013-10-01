class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :video
      t.string :content
      t.boolean :publish

      t.timestamps
    end
  end
end
