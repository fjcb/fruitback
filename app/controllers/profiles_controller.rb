class ProfilesController < ApplicationController
  
  load_and_authorize_resource :user, parent: false, except: :check
  
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
  
  # Admin only ;)
  def upgrade
    @user = User.find(params[:id])
    @user.customer = true
    @user.save!
    flash[:notice] = "This user was upgraded successfully."
    redirect_to profile_path(@user)
  end
  
end
