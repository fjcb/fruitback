class RegistrationsController < Devise::RegistrationsController
  
  protected
  
  def after_sign_up_path_for(resource)
    current_user.customer = true
    current_user.save
    super
  end
  
end
