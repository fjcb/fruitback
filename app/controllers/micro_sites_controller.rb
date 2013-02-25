class MicroSitesController < ApplicationController
  
  inherit_resources
  load_and_authorize_resource :site
  
  defaults :resource_class => Site,
    :collection_name => 'sites',
    :instance_name => 'site'
  
  layout 'micro_site'
  
  def show
    @site = Site.find(params[:id])
    @ideas = @site.ideas.limit(5)
    @idea = Idea.new
    @user = User.new
    @form_url = micro_site_micro_ideas_path(@site)
    super
  end
  
end
