class SessionsController < Devise::SessionsController
  
  layout 'customer_site'
  
  def after_sign_in_path_for(user)
    if user.visitor?
      sites_path
    else
      customer_sites_path
    end
  end
  
end