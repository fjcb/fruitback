class RegistrationsController < Devise::RegistrationsController
  
  layout 'customer_site'
  
  protected
  
  def after_sign_up_path_for(user)
    user.customer = true
    user.save
    super
  end
  
end
