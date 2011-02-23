module Wholesale::ProductsHelper
  def self.included(target)
    target.class_eval do
      def product_price(product_or_variant, options={})
        options.assert_valid_keys(:format_as_currency, :show_vat_text)
        options.reverse_merge! :format_as_currency => true, :show_vat_text => Spree::Config[:show_price_inc_vat]
        if (!current_user.nil? && current_user.has_role?("wholesale") && !product_or_variant.wholesale_price.blank?)          
          amount = product_or_variant.wholesale_price
          logger.info "[wholesale] printing wholesale: #{amount} for "+ (product_or_variant.is_a?(Product) ? "[product] #{product_or_variant.id.to_s}" : "[variant] #{product_or_variant.id} or #{product_or_variant.class}").to_s
        else
          ##############################################
          # ZONE_PRICING compatability
          ##############################################
          # Check if this object is a product, if so then access the master variant
          # record for the product to get the zone pricing
          object = product_or_variant.is_a?(Product) ? product_or_variant.master : product_or_variant

          # Get the zone price for this variant/product if one is defined
          # otherwise use the normal price
          if object.respond_to?(:zone_price)
            amount = object.zone_price(get_user_country_id)
          else
            amount = object.price
          end
          logger.info "[wholesale] NOT printing wholesale: #{amount}"
        end
        amount += Calculator::Vat.calculate_tax_on(product_or_variant) if Spree::Config[:show_price_inc_vat]
        options.delete(:format_as_currency) ? format_price(amount, options) : ("%0.2f" % amount).to_f
      end
    end
  end
end
