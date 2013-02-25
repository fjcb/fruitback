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
    super do |format|
      format.html {
        redirect_to customer_site_path(@site)
      }
    end
  end
  
  def show
    @site = Site.find(params[:id])
    
    return if redirect?(@site)
    
    @ideas = @site.ideas
    @idea = Idea.new
    
    @form_url = customer_site_path(@site)
    super
  end
  
  def edit
    @site = Site.find(params[:id])
    @form_url = customer_site_path(@site)
    super
  end
  
  def update
    @site = Site.find(params[:id])
    @site.update_attributes(params[:site])
    super do |format|
      format.html {
        redirect_to edit_customer_site_path(@site)
      }
    end
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
