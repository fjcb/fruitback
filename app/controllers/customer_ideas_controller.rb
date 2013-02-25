class CustomerIdeasController < ApplicationController

  inherit_resources
  
  defaults :resource_class => Site,
    :collection_name => 'sites',
    :instance_name => 'site' 
 
  layout 'customer_site'
  
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
