class CustomerCommentsController < ApplicationController

  inherit_resources
  skip_load_and_authorize_resource :comment, parent: false
  
  defaults :resource_class => Comment,
    :collection_name => 'comments',
    :instance_name => 'comment' 
 
  layout 'customer_site'
  
  def create
    
    @site = Site.find(params[:customer_site_id])
    @idea = Idea.find(params[:customer_idea_id])

    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    
    @idea.comments.push @comment
    @idea.save
    
    super do |format|
      format.html {
        redirect_to customer_site_customer_idea_path(@site, @idea)
      }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @idea = @comment.idea
    @site = @idea.site
    super do |format|
      format.html {
        redirect_to customer_site_customer_idea_path(@site, @idea), notice: "Comment was successfully deleted."
      }
    end
  end

end
