class AddIndexOnWholesaleProducts < ActiveRecord::Migration
  def self.up
    add_index :wholesale_products, :user_id
    add_index :wholesale_products, :variant_id
  end

  def self.down
    remove_index :wholesale_products, :variant_id
    remove_index :wholesale_products, :user_id
  end
end