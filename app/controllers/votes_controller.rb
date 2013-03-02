class VotesController < ApplicationController
  
  authorize_resource
  
  # JSON only
  def create
    @idea = Idea.find(params[:idea_id])
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
    
    render json: { score: @idea.score }
  end

end
