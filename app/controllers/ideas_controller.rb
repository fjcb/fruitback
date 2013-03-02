class IdeasController < ApplicationController
  
  authorize_resource
  
  # Show all ideas of a site
  def index
    prepare_index
    @idea = Idea.new
  end
  
  def create
    @idea = Idea.new(params[:idea])
    
    # login through form
    if not login!
      prepare_index
      flash[:alert] = "Invalid email or password."
      render :index
      return
    end
    
    @idea.user = current_user
    @site = Site.find(params[:site_id])
    @idea.site_id = @site.id
    @idea.save
    
    if @idea.errors.present?
      prepare_index
      render :index
      return
    end
    
    flash[:notice] = "Idea was successfully added."
    redirect_to site_idea_comments_path(@site, @idea)
  end
  
  def destroy
    @idea = Idea.find(params[:id])
    @site = @idea.site
    
    @idea.destroy
    
    flash[:notice] = "Idea was successfully deleted."
    redirect_to site_ideas_path(@site)
  end
  
  def show
    @idea = Idea.find(params[:id])
    @site = @idea.site
    redirect_to site_idea_comments_path(@site, @idea)
  end
  
  protected
  
  def prepare_index
    @site = Site.find(params[:site_id])
    @ideas = @site.ideas
    @ideas.sort! { |a, b| [b.votes.count, a.title] <=> [a.votes.count, b.title] }
    @user = User.new
    @ideas_url = site_ideas_path(@site)
  end
  
end
