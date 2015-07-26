class AddAttachmentImageToBlogArticles < ActiveRecord::Migration
  def self.up
    change_table :blog_articles do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :blog_articles, :image
  end
end
