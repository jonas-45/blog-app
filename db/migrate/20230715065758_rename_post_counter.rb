class RenamePostCounter < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :postsCounter, :post_counter
  end
end
