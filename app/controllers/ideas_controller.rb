class IdeasController < ApplicationController
  
  inherit_resources
  
  def show
    @idea = Idea.find(params[:id])
    @site = Site.find(params[:site_id])
    @form_url = site_idea_path(@site, @idea)
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
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    @site = Site.find(params[:site_id])
    @site.ideas.push @idea
    @site.save
    super do |format|
      format.html {
        redirect_to site_ideas_path(@site),
        notice: "Idea was successfully created. You have 5 minutes left to edit it."
      }
    end
  end
  
end
