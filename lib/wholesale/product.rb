module Wholesale::Product
  def self.included(model)
    model.class_eval do
      delegate_belongs_to :master, :wholesale_price
    end
  end
end