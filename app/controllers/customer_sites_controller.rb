class CustomerSitesController < ApplicationController
  
  inherit_resources
  load_and_authorize_resource :site, except: :widget
  
  defaults :resource_class => Site,
    :collection_name => 'sites',
    :instance_name => 'site'
  
  layout 'customer_site'
  
  # CUSTOMER VIEW
  
  def index
    
    return if redirect?
    
    @site = Site.new
    if admin?
      @sites = Site.all
    elsif customer?
      @sites = Site.where(user_id: current_user)
    end
    
    @form_url = customer_sites_path
    
    super
  end
  
  def create
    @site = Site.new(params[:site])
    @site.user = current_user
    @site.save
    super
  end
  
  def show
    @site = Site.find(params[:id])
    
    return if redirect?(@site)
    
    @ideas = @site.ideas
    @idea = Idea.new
    super
  end
  
  def widget
    @site = Site.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  
  protected
  
  def redirect?(site = nil)
    path = site ? site_path(site) : sites_path
    if !user_signed_in? || visitor?
      redirect_to path
      return true
    end
    false
  end
  
end
