class UsersController < ApplicationController
  
  inherit_resources
  load_and_authorize_resource except: :check
  
  layout 'customer_site'
  
  def check
    user = User.find_by_email(params[:email])
    render json: !!user
  end
  
end
