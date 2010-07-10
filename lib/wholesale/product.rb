module Wholesale::Product
  def self.included(model)
    model.class_eval do
      if ActiveRecord::Base.connection.table_exists?(Variant.to_s)
        delegate_belongs_to :master, :wholesale_price if Variant.column_names('wholesale_price')
      end
    end
  end
end