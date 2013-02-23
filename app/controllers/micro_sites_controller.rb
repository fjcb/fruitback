class MicroSitesController < ApplicationController
  
  layout 'micro_site'
  
  def show
    @site = Site.find(params[:id])
    @ideas = @site.ideas
    @idea = Idea.new
  end
  
end
