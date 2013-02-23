class SitesController < ApplicationController
  
  inherit_resources
  load_and_authorize_resource
  
  def index
    
    @site = Site.new
    if admin?
      @sites = Site.all
    elsif customer?
      @sites = Site.where(user_id: current_user)
    elsif logged_in?
      # Sites that own one of my ideas or comments
      @sites = []
      current_user.comments.each { |comment|
        site = comment.idea.site
        if !@sites.include? site
          @sites.push site
        end
      }
      current_user.ideas.each { |idea|
        site = idea.site
        if !@sites.include? site
          @sites.push site
        end
      }
    else
      redirect_to root_path
      return
    end
    
    super
  end
  
  def show
    @site = Site.find(params[:id])
    @ideas = @site.ideas
    @idea = Idea.new
    super
  end
  
  def create
    @site = Site.new(params[:site])
    @site.user = current_user
    @site.save
    super
  end
  
  def widget
    @site = Site.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
end
