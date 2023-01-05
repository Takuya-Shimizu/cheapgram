class AddFeedRefToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_reference :favorites, :feed, foreign_key: true
  end
end
