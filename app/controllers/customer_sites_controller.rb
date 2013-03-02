class CustomerSitesController < ApplicationController
  
  inherit_resources
  authorize_resource :site, parent: false, except: :widget
  
  defaults :resource_class => Site,
    :collection_name => 'sites',
    :instance_name => 'site'
  
  layout 'customer_site'
  
  # CUSTOMER VIEW
  
  def index
    return if redirect?
    @site = Site.new
    @sites = admin? ? Site.all : current_user.sites
    @form_url = customer_sites_path
    super
  end
  
  def create
    return if redirect?
    @site = Site.new(params[:site])
    @site.user = current_user
    super do |format|
      if @site.save
        format.html {
          redirect_to customer_site_path(@site)
        }
      else
        format.html {
          # Prepare index view to be rendered
          @sites = admin? ? Site.all : current_user.sites
          @form_url = customer_sites_path
          render :index
        }
      end
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
    #authorize! :edit, @site
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
  
  def backup
    @site = Site.find(params[:id])
    
    votes = { votes: { include: :user } }
    comments = { comments: { include: :user } }
    responses = { responses: { include: :user } }
    
    data = render_to_string json: @site.as_json(
      include: { ideas: { include: [ 
          :user,
          votes, 
          comments,
          responses, 
        ] } } )
        
    send_data data, type: "text/json",filename: "backup.json"
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
