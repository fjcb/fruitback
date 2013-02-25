class IdeasController < ApplicationController
  
  inherit_resources
  skip_load_and_authorize_resource
  
  def show
    @idea = Idea.find(params[:id])
    @site = @idea.site
    #@site = Site.find(params[:site_id])
    @form_url = site_idea_path(@site, @idea)
    @comment = Comment.new
    @user = User.new
    super
  end
  
  def update
    @site = Site.find(params[:site_id])
    super do |format|
      format.html { redirect_to site_idea_path(@site, @idea) }
    end
  end
  
  def create
    
    @site = Site.find(params[:site_id])
    
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
        redirect_to site_idea_path(@site, @idea)
      }
    end
  end
  
end
