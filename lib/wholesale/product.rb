module Wholesale::Product
  def self.included(model)
    model.class_eval do
      delegate_belongs_to :master, :wholesale_price if Variant.table_exists? && Variant.column_names.include?('wholesale_price')
    end
  end
end