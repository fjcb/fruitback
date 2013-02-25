class SitesController < ApplicationController
  
  inherit_resources
  authorize_resource
  
  layout 'customer_site', only: 'index'
  
  # USER VIEW
  
  def index
    
    if user_signed_in?
      # Sites that own one of my ideas or comments
      @sites = []
      current_user.comments.each { |comment|
        site = comment.idea.site
        if !@sites.include? site
          @sites.push site
        end
      }
      current_user.ideas.each { |idea|
        site = idea.site
        if !@sites.include? site
          @sites.push site
        end
      }
    end
    
    super
  end
  
  def show
    @site = Site.find(params[:id])
    @customer = User.find(@site.user.id)
    @customer_sites = Site.where(user_id: @customer.id)
    @ideas = @site.ideas
    @idea = Idea.new
    @user = User.new
    super
  end
  
end
