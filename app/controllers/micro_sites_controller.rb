class MicroSitesController < ApplicationController
  
  layout 'micro_site'
  
  def show
    @site = Site.find(params[:id])
  end
  
end
