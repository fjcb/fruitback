class CommentsController < ApplicationController
  
  inherit_resources
  
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
    
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    
    @idea = Idea.find(params[:idea_id])
    @idea.comments.push @comment
    @idea.save
    
    @site = Site.find(params[:site_id])
    super do |format|
      format.html {
        redirect_to site_idea_path(@site, @idea)
      }
    end
  end
  
end
