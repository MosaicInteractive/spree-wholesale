class AddWholesaleRole < ActiveRecord::Migration
  def self.up
    # to avoid collision with rake db:bootstrap
    unless Role.find_by_name('wholesale')
      role = Role.new(:name => 'wholesale')
      role.id = 3
      role.save!
    end
  end

  def self.down
  end
end