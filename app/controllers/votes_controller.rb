class VotesController < ApplicationController
  
  authorize_resource
  
  # JSON only
  def create
    @site = Site.find(params[:site_id])
    @idea = Idea.find(params[:idea_id])
    
    if user_signed_in?
      @vote = Vote.find_by_user_id_and_idea_id(current_user, @idea)
      if @vote
        @vote.destroy
      else
        @vote = Vote.new(params[:vote])
        @vote.score = 1
        @vote.user_id = current_user.id
        @vote.idea_id = @idea.id
        @vote.save
      end
    end
    
    respond_to do |format|
      format.json {
        render json: { score: @idea.score }
      }
    end
  end

end
