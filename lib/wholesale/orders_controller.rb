module Wholesale::OrdersController
  def self.included(controller)
    controller.class_eval do
      
      def create_before
        params[:products].each do |product_id,variant_id|
          quantity = params[:quantity].to_i if !params[:quantity].is_a?(Array)
          quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Array)
          variant = Variant.find(variant_id)
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)          
            variant.price = variant.wholesale_price
          end
          @order.add_variant(variant, quantity) if quantity > 0
        end if params[:products]

        params[:variants].each do |variant_id, quantity|
          quantity = quantity.to_i
          variant = Variant.find(variant_id)
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)          
            variant.price = variant.wholesale_price
          end
          @order.add_variant(variant, quantity) if quantity > 0
        end if params[:variants]

        # store order token in the session
        session[:order_token] = @order.token
      end
      
    end
  end
end