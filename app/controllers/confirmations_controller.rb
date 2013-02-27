class ConfirmationsController < Devise::ConfirmationsController
  
  layout 'customer_site'
  
  def after_confirmation_path_for(user)
    user.customer = true
    user.save
    customer_sites_path
  end
  
end