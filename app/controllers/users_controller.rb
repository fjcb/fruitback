class UsersController < ApplicationController
  
  inherit_resources
  authorize_resource except: :check
  
  layout 'customer_site'
  
  def show
    @user = User.find(params[:id])
  end
  
  def check
    user = User.find_by_email(params[:email])
    render json: !!user
  end

end
