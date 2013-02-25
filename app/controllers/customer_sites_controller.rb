class CustomerSitesController < ApplicationController
  
  inherit_resources
  
  defaults :resource_class => Site,
    :collection_name => 'sites',
    :instance_name => 'site'
    
  layout 'customer_site'
  
  def show
    @site = Site.find(params[:id])
    @customer = User.find(@site.user.id)
    @customer_sites = Site.where(user_id: @customer.id)
    @ideas = @site.ideas
    @idea = Idea.new
    super
  end
  
end
