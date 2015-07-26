class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.text :short_description

      t.timestamps null: false
    end
  end
end
