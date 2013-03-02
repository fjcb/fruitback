class ConfirmationsController < Devise::ConfirmationsController
  
  layout 'customer_site'
  
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    super if resource.nil? or resource.confirmed? or resource.encrypted_password.present?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token])
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in(resource_name, resource)
      redirect_to sites_path
    else
      render :action => "show"
    end
  end
  
  def after_sign_in_path_for(user)
    if user.visitor?
      sites_path
    else
      customer_sites_path
    end
  end
  
  def after_confirmation_path_for(resource_name, user)
    user.customer = true
    user.save
    customer_sites_path
  end
  
end