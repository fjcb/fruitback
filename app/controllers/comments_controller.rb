class CommentsController < ApplicationController
  
  authorize_resource
  
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
    @idea = Idea.find(params[:idea_id])
    @comment.idea_id = @idea.id
    @comment.save
    
    if @comment.errors.present?
      prepare_index
      render :index
      return
    end
    
    @site = @idea.site
    flash[:notice] = "Comment was successfully added."
    redirect_to site_idea_comments_path(@site, @idea)
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
        redirect_to site_idea_comments_path(@site, @idea)
      }
      format.json { render json: { success: @comment.errors.blank? } }
    end
    
  end
  
  protected
  
  def prepare_index
    @idea = Idea.find(params[:idea_id])
    @site = @idea.site
    @comments = @idea.comments
    @responses = @idea.responses
    @vote = Vote.find_by_user_id_and_idea_id(current_user, @idea) if user_signed_in?
    @user = User.new
    @comments_url = site_idea_comments_path(@site, @idea)
  end
  
end
