class IdeasController < ApplicationController
  
  inherit_resources
  load_and_authorize_resource
  
  def show
    @idea = Idea.find(params[:id])
    @site = @idea.site
    #@site = Site.find(params[:site_id])
    @form_url = site_idea_path(@site, @idea)
    @comment = Comment.new
    super
  end
  
  def index
    @site = Site.find(params[:site_id])
    @idea = Idea.new
    @ideas = @site.ideas
    @form_url = site_ideas_path(@site)
    super
  end
  
  def update
    @site = Site.find(params[:site_id])
    super do |format|
      format.html { redirect_to site_idea_path(@site, @idea) }
    end
  end
  
  def create
    
    if !logged_in?
      user = User.new name: "Anonymous"
      user.save
      sign_in(user)
    end
    
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    
    @site = Site.find(params[:site_id])
    @site.ideas.push @idea
    @site.save
    super do |format|
      format.html {
        redirect_to site_ideas_path(@site)
      }
    end
  end
  
end
