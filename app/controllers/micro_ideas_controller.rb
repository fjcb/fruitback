class MicroIdeasController < ApplicationController
  
  inherit_resources
  authorize_resource :idea, parent: false
  
  defaults :resource_class => Idea,
    :collection_name => 'ideas',
    :instance_name => 'idea'
  
  def create
    
    @site = Site.find(params[:micro_site_id])
    
    if !login
      redirect_to micro_site_path(@site), alert: "Wrong email/password."
      return
    end
    
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    
    @site.ideas.push @idea
    @site.save
    super do |format|
      format.html {
        redirect_to micro_site_path(@site)
      }
    end
  end
  
end
