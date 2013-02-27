class RegistrationsController < Devise::RegistrationsController
  
  layout 'customer_site'
  
  # Ajax call to verify that a user with a given email address exists
  # Returns "true" if exists or "false" if not
  def check
    user = User.find_by_email(params[:email])
    render json: !!user
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
