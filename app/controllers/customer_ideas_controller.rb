class CustomerIdeasController < ApplicationController

  inherit_resources
  authorize_resource :idea, parent: false
  
  defaults :resource_class => Idea,
    :collection_name => 'ideas',
    :instance_name => 'idea' 
 
  layout 'customer_site'
  
  # CUSTOMER VIEW
  
  def show
    @idea = Idea.find(params[:id])
    @site = @idea.site
    @customer = User.find(@site.user.id)
    @response = Response.new
    @comments = @idea.comments
    @comment = Comment.new
    @user = User.new
    @vote = Vote.find_by_user_id_and_idea_id(current_user, @idea) if user_signed_in?
    
    #@form_url = site_idea_path(@site, @idea)
    #super
  end
  
  def destroy
    @idea = Idea.find(params[:id])
    @site = @idea.site
    super do |format|
      format.html {
        redirect_to customer_site_path(@site), notice: "Idea was successfully deleted."
      }
    end
  end
  
end
