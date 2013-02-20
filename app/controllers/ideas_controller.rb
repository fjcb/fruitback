class IdeasController < ApplicationController
  
  inherit_resources
  
  def create
    @site = Site.find(params[:site_id])
    @idea = Idea.new(params[:idea])
    @site.idea = @idea
    @site.save
    super
  end
  
end
