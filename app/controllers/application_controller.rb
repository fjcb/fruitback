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
  
  def login!
    if not user_signed_in?
      # Try to log in existing user
      user = User.find_by_email(params[:user][:email])
      if user
        if not user.valid_password?(params[:user][:password])
          return false
        end
      else
        user = User.new(params[:user])
        
        # email should be nil, not empty
        if user.email.blank?
          user.email = nil
          user.skip_confirmation!
        end
        
        # set anonymous as user name if no name was given
        if user.name.blank?
          user.name = "Anonymous"
        end
        
        user.save!
        
      end
      sign_in(user)
    end
    
    true
  end
  
end
