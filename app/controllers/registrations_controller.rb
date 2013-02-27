class RegistrationsController < Devise::RegistrationsController
  
  layout 'customer_site'
  
  def create
    super
  end
  
  protected
  
  def after_sign_up_path_for(user)
    user.customer = true
    user.save
    customer_sites_path 
    #super
  end
  
  #def after_update_path_for(user)
  #  super
  #  #redirect_to user_path(user)
  #end
  
end
