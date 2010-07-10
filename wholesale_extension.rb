# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class WholesaleExtension < Spree::Extension
  version "0.1"
  description "Add wholesale pricing to products"
  url "http://github.com/pkordel/spree-wholesale"

  # Please use wholesale/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    
    # Reopen the Product class and delegate wholesale_price (first variant)
    Product.send(:include, Wholesale::Product)
    
    # Reopen the ProductsHelper module and redefine the product_price method
    ProductsHelper.send(:include, Wholesale::ProductsHelper)
    
    LineItem.send(:include, Wholesale::LineItem)
    
    OrdersController.send(:include, Wholesale::OrdersController)
    
    Order.send(:include, Wholesale::Order)
    
    UserSessionsController.send(:include, Wholesale::UserSessionsController)
    
    Admin::OrdersController.send(:include, Wholesale::Admin::OrdersController)
    
    Admin::CheckoutsController.send(:include, Wholesale::Admin::CheckoutsController)

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
