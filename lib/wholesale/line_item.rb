module Wholesale::LineItem
  def self.included(model)
    model.class_eval do
      def wholesale_price
        price
      end
    end
  end
end