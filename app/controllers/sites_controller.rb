class SitesController < ApplicationController
  
  inherit_resources
  
  def index
    @site = Site.new
    #@sites = Site.where(name: "Bananinator")
    super
  end
  
  def widget
    @site = Site.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
end
