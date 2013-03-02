class CustomerSitesController < ApplicationController
  
  authorize_resource :site, parent: false, except: :widget
  
  layout 'customer_site'
  
  # CUSTOMER VIEW
  
  def index
    prepare_index
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    @site.user = current_user
    @site.save
    
    if @site.errors.present?
      prepare_index
      render :index
      return
    end
    
    flash[:notice] = "Site was successfully registered."
    redirect_to customer_site_customer_ideas_path(@site)
  end
  
  def edit
    @site = Site.find(params[:id])
    @site_url = customer_site_path(@site)
  end
  
  def update
    @site = Site.find(params[:id])
    @site.update_attributes(params[:site])
    @site.save
    
    if @site.errors.present?
      @site_url = customer_site_path(@site)
      render :edit
      return
    end
    
    flash[:notice] = "Site was successfully updated."
    redirect_to edit_customer_site_path(@site)
  end
  
  def show
    @site = Site.find(params[:id])
    redirect_to customer_site_customer_ideas_path(@site)
  end
  
  def widget
    @site = Site.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  protected
  
  def prepare_index
    @sites = current_user.sites
    @sites_url = customer_sites_path
  end
  
end
