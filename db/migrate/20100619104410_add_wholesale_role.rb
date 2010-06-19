class AddWholesaleRole < ActiveRecord::Migration
  def self.up
    Role.create!(:name => 'wholesale') unless Role.find_by_name('wholesale')
  end

  def self.down
  end
end