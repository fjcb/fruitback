class CommentsController < ApplicationController
  
  inherit_resources
  load_and_authorize_resource
  
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
    if !logged_in?
      user = User.new name: "Anonymous"
      user.save
      sign_in(user)
    end
    
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
