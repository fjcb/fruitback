class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :development?
  helper_method :visitor?
  helper_method :admin?
  helper_method :customer?
  helper_method :anonymous?
  
  helper_method :login
  
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
  
  def login
    if !user_signed_in?
      # Try to log in existing user
      user = User.find_by_email(params[:user][:email])
      if user
        if user.valid_password?(params[:user][:password])
          sign_in(user)
        else
          return false
        end
      else
        user = User.new(params[:user])
        user.name = "Anonymous" if !user.name || user.name.empty?
        user.save
        sign_in(user)
      end
    end
    true
  end
  
end
