module Wholesale::Admin::OrdersController
  def self.included(controller)
    controller.class_eval do
      update do
        flash nil
        wants.html do
          if @order.bill_address.nil? || @order.ship_address.nil?
            redirect_to edit_admin_order_checkout_url(@order)
          else
            redirect_to edit_admin_order_shipment_url(@order, @order.shipment)
          end
        end
      end
    end
  end
end