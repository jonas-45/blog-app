class FixColumnNames < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.rename :commentsCounter, :comments_counter
      t.rename :likesCounter, :likes_counter
    end
  end
end
