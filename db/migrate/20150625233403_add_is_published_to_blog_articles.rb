class AddIsPublishedToBlogArticles < ActiveRecord::Migration
  def change
    add_column :blog_articles, :is_published, :boolean
  end
end
