class MicroIdeasController < ApplicationController
  
  inherit_resources
  
  defaults :resource_class => Idea,
    :collection_name => 'ideas',
    :instance_name => 'idea'
  
  load_and_authorize_resource :idea
  
  def create
    
    if !user_signed_in?
      user = User.new(params[:user])
      user.name = "Anonymous" if !user.name
      user.save
      sign_in(user)
    end
    
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    
    @site = Site.find(params[:micro_site_id])
    @site.ideas.push @idea
    @site.save
    super do |format|
      format.html {
        redirect_to micro_site_path(@site)
      }
    end
  end
  
end
