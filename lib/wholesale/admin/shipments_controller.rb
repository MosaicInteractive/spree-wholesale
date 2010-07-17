module Wholesale::Admin::ShipmentsController
  def self.included(controller)
    controller.class_eval do
      update.wants.html do
        if @order.in_progress?
          redirect_to admin_order_adjustments_url(@order)
        else
          redirect_to edit_object_url
        end
      end
    end
  end
end











