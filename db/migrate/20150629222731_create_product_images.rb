class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :alt_text
      t.attachment :image

      t.timestamps null: false
    end
  end

  def self.down
    remove_attachment :product_images, :image
  end
end
