require 'spec_helper'

describe "deletion" do
  
  before do
    @user = User.create! name: "The user", email: "user@example.com", password: "useruser"
    @customer = User.create! name: "The customer", email: "customer@example.com", password: "customer", customer: true
    
    @site = Site.new name: "The site"
    @site.user_id = @customer.id
    @site.save!
    
    @idea = Idea.new title: "The idea", description: "This is a user's idea."
    @idea.site_id = @site.id
    @idea.user_id = @user.id
    @idea.save!
  end
  
  describe "by user" do
    
    before do
      #logging in as user (fast)
      page.driver.post user_session_path, "user[email]" => "user@example.com", "user[password]" => "useruser"
    end
    
    it "(logged in)" do
      visit root_path
      page.should have_content "Logged in as The user"
    end

    it "of an own idea" do
      visit site_idea_path(@site, @idea)
      
      find("#idea_#{@idea.id}").click_on "Delete"
      
      Idea.find_by_id(@idea).should == nil
    end
    
    describe "of an own idea with response" do
      
      before do
        @state = State.new name: "The state", color: "The color"
        @state.save!
        
        @response = Response.new  text: "This is a customers's reponse."
        @response.state_id = @state.id
        @response.user_id = @customer.id
        @response.idea_id = @idea.id
        @response.save!
        
        visit site_idea_path(@site, @idea)
      end
      
      specify { find("#idea_#{@idea.id}").should_not have_selector("button") }
      
      it { Idea.find_by_id(@idea).should_not == nil }
      
    end
    
    describe "of an own comment" do
      
      before do
        @comment = Comment.new text: "This is a user's comment."
        @comment.user_id = @user.id
        @comment.idea_id = @idea.id
        @comment.save!
        
        visit site_idea_path(@site, @idea)
        find("#comment_#{@comment.id}").click_on "Delete"
      end
      
      specify { Comment.find_by_id(@comment).should == nil }
      
    end
    
    
  end
  
  describe "by customer" do
    
    before do
      #logging in as customer (fast)
      page.driver.post user_session_path, "user[email]" => "customer@example.com", "user[password]" => "customer"
    end
    
    it "(logged in)" do
      visit root_path
      page.should have_content "Logged in as The customer"
    end

    it "of an idea on owned site" do
      visit customer_site_customer_idea_path(@site, @idea)
      
      find("#idea_#{@idea.id}").click_on "Delete"
      
      Idea.find_by_id(@idea).should == nil
    end
    
    describe "of an idea on owned site with response" do
      
      before do
        @state = State.new name: "The state", color: "The color"
        @state.save!
        
        @response = Response.new  text: "This is a customers's reponse."
        @response.state_id = @state.id
        @response.user_id = @customer.id
        @response.idea_id = @idea.id
        @response.save!
        
        visit customer_site_customer_idea_path(@site, @idea)
        find("#idea_#{@idea.id}").click_on "Delete"
      end
      
      it { Idea.find_by_id(@idea).should == nil }
      
      it { Response.find_by_id(@response).should == nil }
      
      it { State.find_by_id(@state).should_not == nil }
      
    end
    
    
    describe "of an comment on owned site" do
      
      before do
        @comment = Comment.new text: "This is a user's comment."
        @comment.user_id = @user.id
        @comment.idea_id = @idea.id
        @comment.save!
        
        visit customer_site_customer_idea_path(@site, @idea)
        find("#comment_#{@comment.id}").click_on "Delete"
      end
      
      specify { Comment.find_by_id(@comment).should == nil }
    end
    
  end
  
end
