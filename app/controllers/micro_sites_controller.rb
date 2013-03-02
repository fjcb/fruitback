class MicroSitesController < ApplicationController
  
  authorize_resource :site, parent: false
  
  layout 'micro_site'
  
  def show
    @site = Site.find(params[:id])
    @ideas = @site.ideas
    @ideas.sort! { |a, b| [b.votes.count, a.title] <=> [a.votes.count, b.title] }
    @idea = Idea.new
    @user = User.new
    @form_url = micro_site_micro_ideas_path(@site)
  end
  
end
