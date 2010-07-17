module Wholesale::User
  def self.included(model)
    model.class_eval do
      has_many :wholesale_products, :dependent => :destroy
      accepts_nested_attributes_for :wholesale_products
      
      def add_wholesale_product(variant)
        return if WholesaleProduct.get(self.id, variant.id)
        self.wholesale_products.build(:variant_id => variant.id)
      end
      
      def is_wholesale_user?
        self.roles.map(&:name).include? 'wholesale'
      end
    end
  end
end