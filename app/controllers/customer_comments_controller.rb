class CustomerCommentsController < ApplicationController

  authorize_resource :comment, parent: false
  
  layout 'customer_site'
  
  # Show all comments of an idea
  def index
    prepare_index
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    
    # login through form
    if not login!
      prepare_index
      flash[:alert] = "Invalid email or password."
      render :index
      return
    end
    
    @comment.user = current_user
    @idea = Idea.find(params[:customer_idea_id])
    @comment.idea_id = @idea.id
    @comment.save
    
    if @comment.errors.present?
      prepare_index
      render :index
      return
    end
    
    @site = @idea.site
    flash[:notice] = "Comment was successfully added."
    redirect_to customer_site_customer_idea_customer_comments_path(@site, @idea)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @idea = @comment.idea
    @site = @idea.site
    
    @comment.destroy
    
    respond_to do |format|
      format.html {
        if @comment.errors.present?
          prepare_index
          render :index
          return
        end
        
        flash[:notice] = "Comment was successfully deleted."
        redirect_to customer_site_customer_idea_customer_comments_path(@site, @idea)
      }
      format.json { render json: { success: @comment.errors.blank? } }
    end
  end
  
  protected
  
  def prepare_index
    @idea = Idea.find(params[:customer_idea_id])
    @site = @idea.site
    @comments = @idea.comments
    @vote = Vote.find_by_user_id_and_idea_id(current_user, @idea) if user_signed_in?
    @user = User.new
    @response = Response.new
    @comments_url = customer_site_customer_idea_customer_comments_path(@site, @idea)
  end
  
end
