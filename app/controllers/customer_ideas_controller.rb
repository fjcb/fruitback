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
    @customer_sites = Site.where(user_id: @customer.id)
    @form_url = site_idea_path(@site, @idea)
    @comment = Comment.new
    super
  end
end
