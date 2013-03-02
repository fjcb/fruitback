class MicroSitesController < ApplicationController
  
  authorize_resource :site, parent: false
  
  layout 'micro_site'
  
  def show
    @site = Site.find(params[:id])
    redirect_to micro_site_micro_ideas_path(@site)
  end

end
