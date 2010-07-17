module Wholesale::Admin::PaymentsController
  def self.included(controller)
    controller.class_eval do
      
      def object_params
        if params[:payment] and params[:payment_source] and source_params = params.delete(:payment_source)[params[:payment][:payment_method_id]]
          source_params.merge!({"first_name" => @bill_address.firstname, "last_name" => @bill_address.lastname})
          params[:payment][:source_attributes] = source_params
        end
        params[:payment]
      end
      
      def load_data
        load_object
        @payment_methods = PaymentMethod.available(:back_end)
        if object and object.payment_method
          @payment_method = object.payment_method
        else
          @payment_method = @payment_methods.first
        end
        @previous_cards = @order.creditcards.with_payment_profile
        @countries = Country.find(:all).sort
        @shipping_countries = Checkout.countries.sort
        if @order.user && @order.user.bill_address
          @bill_address = @order.user.bill_address
          default_country = @order.user.bill_address.country
        else
          default_country = Country.find Spree::Config[:default_country_id]
        end
        @states = default_country.states.sort
      end
      
    end
  end
end