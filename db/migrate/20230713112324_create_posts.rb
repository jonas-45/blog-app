class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.string :text
      t.integer :commentsCounter
      t.integer :likesCounter

      t.timestamps
    end
    add_index :posts, :author_id
  end
end
