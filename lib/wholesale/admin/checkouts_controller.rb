module Wholesale::Admin::CheckoutsController
  def self.included(controller)
    controller.class_eval do
      update.wants.html do
        if @order.in_progress?
          redirect_to edit_admin_order_url(@order)
        else
          redirect_to admin_order_checkout_url(@order)
        end
      end
    end
  end
end