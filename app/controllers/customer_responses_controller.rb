class CustomerResponsesController < ApplicationController

  authorize_resource :response, parent: false
  
  layout 'customer_site'
  
  def create
    @idea = Idea.find(params[:customer_idea_id])
    @site = @idea.site
    
    @response = Response.new(params[:response])
    @response.user_id = current_user.id
    @response.idea_id = @idea.id
    @response.save
    
    flash[:notice] = "Response was successfully added."
    redirect_to customer_site_customer_idea_customer_comments_path(@site, @idea)
  end

end
