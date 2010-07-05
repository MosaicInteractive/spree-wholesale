# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class WholesaleExtension < Spree::Extension
  version "0.1"
  description "Add wholesale pricing to products"
  url "http://github.com/mlambie/spree-wholesale"

  # Please use wholesale/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end
    
    # Reopen the Product class and delegate wholesale_price (first variant)
    Product.send(:include, Wholesale::Product)
    
    # Reopen the ProductsHelper module and redefine the product_price method
    ProductsHelper.send(:include, Wholesale::ProductsHelper)
    
    LineItem.send(:include, Wholesale::LineItem)
    
    OrdersController.send(:include, Wholesale::OrdersController)
    
    Order.send(:include, Wholesale::Order)
    
    UserSessionsController.send(:include, Wholesale::UserSessionsController)

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
