class CommentsController < ApplicationController
  
  inherit_resources
  skip_load_and_authorize_resource
  
  def update
    @idea = Idea.find(params[:idea_id])
    @site = Site.find(params[:site_id])
    super do |format|
      format.html {
        redirect_to site_idea_path(@site, @idea)
      }
    end
  end
  
  def create
    
    @site = Site.find(params[:site_id])
    @idea = Idea.find(params[:idea_id])
    
    if !login
      redirect_to site_idea_path(@site, @idea), alert: "Wrong email/password."
      return
    end
    
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    
    @idea.comments.push @comment
    @idea.save
    
    super do |format|
      format.html {
        redirect_to site_idea_path(@site, @idea)
      }
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @idea = @comment.idea
    @site = @idea.site
    super do |format|
      format.html {
        redirect_to site_idea_path(@site, @idea), notice: "Comment was successfully deleted."
      }
    end
  end
  
end
