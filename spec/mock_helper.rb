
module MockHelper
    
  def mock
    @user = User.create! name: "The user", email: "user@example.com"
    @customer = User.create! name: "The customer", email: "customer@example.com", customer: true
    
    @site = Site.new name: "The site"
    @site.user_id = @customer.id
    @site.save!
    
    @idea = Idea.new title: "The idea", description: "This is a user's idea."
    @idea.site_id = @site.id
    @idea.user_id = @user.id
    @idea.save!
    
    @comment = Comment.new text: "This is a user's comment."
    @comment.user_id = @user.id
    @comment.idea_id = @idea.id
    @comment.save!
    
    @vote = Vote.new
    @vote.score = 1
    @vote.user_id = @user.id
    @vote.idea_id = @idea.id
    @vote.save!
    
    @state = State.new name: "The state", color: "The color"
    @state.save!
    
    @response = Response.new  text: "This is a customers's reponse."
    @response.state_id = @state.id
    @response.user_id = @customer.id
    @response.idea_id = @idea.id
    @response.save!
  end
end