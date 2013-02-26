class CustomerResponsesController < ApplicationController

  authorize_resource :response, parent: false
  
  layout 'customer_site'
  
  def create
    @site = Site.find(params[:customer_site_id])
    @idea = Idea.find(params[:customer_idea_id])
    
    if admin? || customer? && current_user.sites.include?(@site)
      @response = Response.new(params[:response])
      @response.user_id = current_user.id
      @response.idea_id = @idea.id
      @response.save
      redirect_to customer_site_customer_idea_path(@site, @idea), notice: "Response was successfully added."
      return
    end
    
    flash[:alert] = "Something went wrong."
    redirect_to customer_site_customer_idea_path(@site, @idea)
  end

end
