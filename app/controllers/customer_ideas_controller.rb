class CustomerIdeasController < ApplicationController

  authorize_resource :idea, parent: false
  
  layout 'customer_site'
  
  # CUSTOMER VIEW
  
  def index
    prepare_index
  end
  
  def destroy
    @idea = Idea.find(params[:id])
    @site = @idea.site
    
    @idea.destroy
    
    flash[:notice] = "Idea was successfully deleted."
    redirect_to customer_site_customer_ideas_path(@site)
  end
  
  def show
    @idea = Idea.find(params[:id])
    @site = @idea.site
    redirect_to customer_site_customer_idea_customer_comments_path(@site, @idea)
  end
  
  protected
  
  def prepare_index
    @site = Site.find(params[:customer_site_id])
    @ideas = @site.ideas
  end
end
