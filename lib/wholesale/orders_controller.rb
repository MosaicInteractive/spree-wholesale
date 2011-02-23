module Wholesale::OrdersController
  def self.included(controller)
    controller.class_eval do
      
      def create_before
        # dropdown_variant compatability:
        # Check for dropdown_variant extension's param alteration
        if params[:product] and params[:option_types]
          variant = Variant.find_by_option_types_and_product(params[:option_types], params[:product])
          quantity = params[:quantity].to_i
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)
            variant.price = variant.wholesale_price
          end
          @order.add_variant(variant, quantity) if quantity > 0
        end

        params[:products].each do |product_id,variant_id|
          quantity = params[:quantity].to_i if !params[:quantity].is_a?(Array)
          quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Array)
          logger.info "[wholesale] Adding (#{quantity} of #{products.count} prods) wholesale item: #{product_id}, #{variant_id}"
          variant = Variant.find(variant_id)
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)          
            variant.price = variant.wholesale_price
            logger.info"[wholesale] Added PRODUCT variant with wholesale_prce: (#{variant.id}) $#{variant.wholesale_price}"
          else
            logger.info "[wholesale] ERROR: added PRODUCT variant without wholesale - (#{current_user.roles.to_s}) $#{variant.wholesale_price}"
          end
          @order.add_variant(variant, quantity) if quantity > 0 
        end if params[:products]

        params[:variants].each do |variant_id, quantity|
          quantity = quantity.to_i
          variant = Variant.find(variant_id)
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)          
            variant.price = variant.wholesale_price
            logger.info "[wholesale] Added VARIANT with wholesale_prce: (#{variant.id}) $#{variant.wholesale_price}"
          else
            logger.info "[wholesale] ERROR: added variant without wholesale - (#{current_user.roles.to_s}) $#{variant.wholesale_price}"
          end
          @order.add_variant(variant, quantity) if quantity > 0
        end if params[:variants]

        logger.info "[wholesale] Finished mocking up prices for wholesalers"
        # store order token in the session
        session[:order_token] = @order.token
      end
      
    end
  end
end
