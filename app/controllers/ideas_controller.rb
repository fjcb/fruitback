class IdeasController < ApplicationController
  
  inherit_resources
  authorize_resource
  
  def show
    @idea = Idea.find(params[:id])
    @site = Site.find(params[:site_id])
    @form_url = site_idea_path(@site, @idea)
    @comments = @idea.comments
    @comment = Comment.new
    @user = User.new
    @vote = Vote.find_by_user_id_and_idea_id(current_user, @idea) if user_signed_in?
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
    
    if !login
      redirect_to site_path(@site), alert: "Wrong email/password."
      return
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
