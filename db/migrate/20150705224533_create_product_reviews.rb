class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.string :name
      t.text :body
      t.integer :rating
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
