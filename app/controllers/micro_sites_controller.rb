class MicroSitesController < ApplicationController
  
  layout 'micro_site'
  
  def show
    @site = Site.find(params[:id])
    @ideas = @site.ideas.limit(15)
    @idea = Idea.new
    @user = User.new
  end
  
end
