class RemoveBlogFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :blog_id, :bigint
  end
end
