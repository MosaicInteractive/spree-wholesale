module Wholesale::Order
  def self.included(model)
    model.class_eval do
      def force_wholesale
        self.line_items.each do |item|
          item.price = Variant.find_by_id(item.variant_id).wholesale_price
        end
        self.save!
      end
      
      def force_retail
        self.line_items.each do |item|
          item.price = Variant.find_by_id(item.variant_id).price
        end
        self.save!
      end
    end
  end
end