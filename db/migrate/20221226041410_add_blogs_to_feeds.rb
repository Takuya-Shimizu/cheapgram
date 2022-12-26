class AddBlogsToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :title, :text
    add_column :feeds, :content, :text
  end
end
