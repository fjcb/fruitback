class MicroIdeasController < ApplicationController
  
  inherit_resources
  
  defaults :resource_class => Idea,
    :collection_name => 'ideas',
    :instance_name => 'idea'
  
  load_and_authorize_resource :idea
  
  def create
    
    @site = Site.find(params[:micro_site_id])
    
    if !user_signed_in?
      # Try to log in existing user
      user = User.find_by_email(params[:user][:email])
      if user
        if user.valid_password?(params[:user][:password])
          sign_in(user)
        else
          respond_to do |format|
            format.html {
              redirect_to micro_site_path(@site), alert: "Wrong email/password."
              return
            }
          end
        end
      else
        user = User.new(params[:user])
        user.name = "Anonymous" if !user.name
        user.save
        sign_in(user)
      end
    end
    
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    
    @site.ideas.push @idea
    @site.save
    super do |format|
      format.html {
        redirect_to micro_site_path(@site)
      }
    end
  end
  
end
