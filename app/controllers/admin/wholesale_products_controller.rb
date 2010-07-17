class Admin::WholesaleProductsController < Admin::BaseController
  resource_controller
  belongs_to :user
  ssl_required
  actions :all
  
  create.flash nil
  update.flash nil
  destroy.flash nil
  
  def create
    debugger
    load_object
    variant = Variant.find(params[:wholesale_product][:variant_id])
    @user.add_wholesale_product(variant)
    if @user.save
      after :create
      set_flash :create
      response_for :create
    else
      after :create_fails
      set_flash :create_fails
      response_for :create_fails
    end
  end
  
  destroy.success.wants.html { render :partial => "admin/users/wp_form", :locals => {:user => @user}, :layout => false }
  destroy.failure.wants.html { render :partial => "admin/users/wp_form", :locals => {:user => @user}, :layout => false }
  
  create.response do |wants|
    wants.html { render :partial => "admin/users/wp_form", :locals => {:user => @user}, :layout => false}
  end
  
  update.success.wants.html { render :partial => "admin/users/wp_form", :locals => {:user => @user}, :layout => false}
  update.failure.wants.html { render :partial => "admin/users/wp_form", :locals => {:user => @user}, :layout => false}
  
end
