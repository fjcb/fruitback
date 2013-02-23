class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :development?
  helper_method :admin?
  helper_method :customer?
  helper_method :anonymous?
  helper_method :logged_in?
  
  protected
  
  def development?
    Rails.env.development?
  end
  
  def admin?
    current_user.try(:admin?)
  end
  
  def customer?
    current_user.try(:customer?)
  end
  
  def anonymous?
    !current_user.try(:email)
  end
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      sites_path
    else
      super
    end
  end
  
end
