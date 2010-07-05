module Wholesale::UserSessionsController
  def self.included(controller)
    controller.class_eval do
      
      before_filter :force_retail, :only => [:destroy]
      
      def create
        @user_session = UserSession.new(params[:user_session])
        success = @user_session.save
        respond_to do |format|
          format.html {                                
            if success 
              modify_order_on_login
              flash[:notice] = t("logged_in_succesfully")
              redirect_back_or_default products_path
            else
              flash.now[:error] = t("login_failed")
              render :new
            end
          }
          format.js {
            user = success ? @user_session.record : nil
            render :json => user ? {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json : success.to_json
          }
        end    
      end
      
      private
      def modify_order_on_login
        user = User.find_by_id(session["user_credentials_id"]) || User.new
        user.has_role?("wholesale") ? force_wholesale : force_retail
      end
      
      def force_retail(order = Order.find_by_id(session[:order_id]))
        order.force_retail if !order.nil? && order.state == 'in_progress'
      end
      
      def force_wholesale(order = Order.find_by_id(session[:order_id]))
        order.force_wholesale if !order.nil? && order.state == 'in_progress'
      end
    end
  end
end