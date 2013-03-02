class SitesController < ApplicationController
  
  authorize_resource
  
  layout 'customer_site', only: 'index'
  
  # USER VIEW
  
  def index
    @sites = []
    if user_signed_in?
      # Sites that own one of my ideas or comments
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
  end
  
  def show
    @site = Site.find(params[:id])
    redirect_to site_ideas_path(@site)
  end
  
end
