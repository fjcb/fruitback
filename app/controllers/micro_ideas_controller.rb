class MicroIdeasController < ApplicationController
  
  load_and_authorize_resource :idea, parent: false
  
  layout 'micro_site'
  
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
    @site = Site.find(params[:micro_site_id])
    @idea.site_id = @site.id
    @idea.save
    
    if @idea.errors.present?
      prepare_index
      render :index
      return
    end
    
    flash[:notice] = "Idea was successfully added."
    redirect_to micro_site_micro_ideas_path(@site)
  end
  
  protected
  
  def prepare_index
    @site = Site.find(params[:micro_site_id])
    @ideas = @site.ideas
    @ideas.sort! { |a, b| [b.votes.count, a.title] <=> [a.votes.count, b.title] }
    @user = User.new
    @ideas_url = micro_site_micro_ideas_path(@site)
  end
end
