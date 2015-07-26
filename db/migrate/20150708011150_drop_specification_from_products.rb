class DropSpecificationFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :specification
  end
end
