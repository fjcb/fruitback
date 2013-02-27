require 'spec_helper'

describe 'testing model' do

  before do
    
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
  
  describe User do
    
    describe "is nameless" do
        
      before do
        @nameless_user = User.create
      end
      
      subject { @nameless_user }
      
      it { should_not be_valid }
      
    end
    
    subject { @user }
    
    it { should be_valid }
    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :admin }
    it { should respond_to :customer }
    it { should respond_to :sites }
    it { should respond_to :ideas }
    it { should respond_to :comments }
    it { should respond_to :votes }
    it { should respond_to :responses }
    
  end
  
  describe Site do
    
    subject { @site }
    
    it { should be_valid }
    it { should respond_to :name }
    it { should respond_to :url }
    it { should respond_to :user }
    it { should respond_to :ideas }
    
  end
  
  describe Idea do
    
    subject { @idea }
    
    it { should be_valid }
    it { should respond_to :title }
    it { should respond_to :description }
    it { should respond_to :user }
    it { should respond_to :site }
    it { should respond_to :comments }
    it { should respond_to :responses }
    
  end
  
  describe Comment do
    
    subject { @comment }
    
    it { should be_valid }
    it { should respond_to :text }
    it { should respond_to :user }
    it { should respond_to :idea }
    
    #visit
  
  end
  
  describe Vote do
    
    subject { @vote }
    
    it { should be_valid }
    it { should respond_to :score }
    it { should respond_to :user }
    it { should respond_to :idea }
    
  end
  
  describe State do
    
    subject { @state }
    
    it { should be_valid }
    it { should respond_to :name }
    it { should respond_to :color }
    
    # This direction is explicitly not allowed
    it { should_not respond_to :responses }
    
  end
  
  describe Response do
    
    subject { @response }
    
    it { should be_valid }
    it { should respond_to :text }
    it { should respond_to :state }
    it { should respond_to :user }
    it { should respond_to :idea }
    
  end
  
  
end
