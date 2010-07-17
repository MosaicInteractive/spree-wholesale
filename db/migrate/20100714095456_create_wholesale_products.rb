class CreateWholesaleProducts < ActiveRecord::Migration
  def self.up
    create_table :wholesale_products do |t|
      t.integer "user_id", :null => false
      t.integer "variant_id", :null => false
      t.decimal "unique_wholesale_price", :precision => 8, :scale => 2
      t.decimal "unique_wholesale_price_usd", :precision => 8, :scale => 2
    end
  end

  def self.down
    drop_table :wholesale_products
  end
end