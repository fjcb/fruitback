class ConfirmationsController < Devise::ConfirmationsController
  
  layout 'customer_site'
  
  def after_confirmation_path_for(resource_name, user)
    user.customer = true
    user.save
    customer_sites_path
  end
  
end