class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :introduction
      t.text :description
      t.text :specification
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
