class ProfilesController < ApplicationController
  
  inherit_resources
  authorize_resource :user, parent: false
  
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
  
end
