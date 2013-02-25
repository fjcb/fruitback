class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :development?
  helper_method :visitor?
  helper_method :admin?
  helper_method :customer?
  helper_method :anonymous?
  helper_method :logged_in?
  
  protected
  
  def development?
    Rails.env.development?
  end
  
  def visitor?
    current_user.try(:visitor?)
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
  
end
