class ProfilesController < ApplicationController
  
  inherit_resources
  authorize_resource :user, parent: false, except: :check
  
  defaults :resource_class => User,
    :collection_name => 'users',
    :instance_name => 'user'
  
  layout 'customer_site'
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def check
    user = User.find_by_email(params[:email])
    render json: !!user
  end
  
  # Admin only ;)
  def confirm
    @user = User.find(params[:id])
    @user.confirm!
    flash[:notice] = "This user's email address was successfully confirmed."
    redirect_to profile_path(@user)
  end
  
end
