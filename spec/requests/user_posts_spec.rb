require 'spec_helper'

describe "UserPosts" do
  
  before do
    
    @user = User.create! name: "The user", email: "user@example.com", password: "useruser"
    @customer = User.create! name: "The customer", email: "customer@example.com", password: "customer", customer: true
    
    @site = Site.new name: "The site"
    @site.user_id = @customer.id
    @site.save!
    
    page.driver.post user_session_path, "user[email]" => "user@example.com", "user[password]" => "useruser"
  
  end
  
  describe "creates idea" do
    
    before do
      visit site_path(@site)
        
      fill_in('idea_title', :with => "Funky idea")
      fill_in('idea_description', :with => 'Description of my funky idea.')
      
      click_on "Post idea"
    end
    
    it "should be valid" do
      page.should have_content "Funky idea"
    end
    
  end
  
  describe "creates idea without title" do
    
    before do
      visit site_path(@site)
        
      fill_in('idea_title', :with => "")
      fill_in('idea_description', :with => 'test')
      
      click_on "Post idea"
    end
    
    it "should not be valid" do
      page.should have_content "something went wrong"
    end
    
    it "should not be saved" do
      Idea.find_by_description('test').should == nil
    end
    
  end
  
  describe "creates idea without description" do
    
    before do
      visit site_path(@site)
        
      fill_in('idea_title', :with => "test")
      fill_in('idea_description', :with => '')
      
      click_on "Post idea"
    end
    
    it "should not be valid" do
      page.should have_content "something went wrong"
    end
    
    it "should not be saved" do
      Idea.find_by_title('test').should == nil
    end
    
  end
  
  describe "creates idea with long title" do
    
    before do
      visit site_path(@site)
        
      fill_in('idea_title', :with => "a" * 101)
      fill_in('idea_description', :with => 'test')
      
      click_on "Post idea"
    end
    
    it "should not be valid" do
      page.should have_content "something went wrong"
    end
    
    it "should not be saved" do
      Idea.find_by_description('test').should == nil
    end
        
  end
  
  describe "creates idea with long description" do
       
    before do
      visit site_path(@site)
        
      fill_in('idea_title', :with => "test")
      fill_in('idea_description', :with => "a" * 1001)
      
      click_on "Post idea"
    end
    
    it "should not be valid" do
      page.should have_content "something went wrong"
    end
    
    it "should not be saved" do
      Idea.find_by_title('test').should == nil
    end
       
  end
  
  describe "creates valid comment" do
    
    before do
      @idea = Idea.new title: "The idea", description: "This is a user's idea."
      @idea.site_id = @site.id
      @idea.user_id = @user.id
      @idea.save!
      
      visit site_idea_path(@site, @idea)
        
      fill_in('comment_text', :with => 'my comment')
      
      click_on "Post comment"
    end
    
    it "should be valid" do
      page.should have_content 'my comment'
    end
    
  end
  
  describe "creates empty comment" do
      
    before do
      @idea = Idea.new title: "The idea", description: "This is a user's idea."
      @idea.site_id = @site.id
      @idea.user_id = @user.id
      @idea.save!
      
      visit site_idea_path(@site, @idea)
        
      fill_in('comment_text', :with => '')
      
      click_on "Post comment"
    end
    
    it "should not be valid" do
      page.should have_content "can't be blank"
    end
    
    it "should not be saved" do
      Comment.all.count.should == 0
    end
    
  end
  
  describe "creates long comment" do
    
    before do
      @idea = Idea.new title: "The idea", description: "This is a user's idea."
      @idea.site_id = @site.id
      @idea.user_id = @user.id
      @idea.save!
      
      visit site_idea_path(@site, @idea)
        
      fill_in('comment_text', :with => "a" * 1001)
      
      click_on "Post comment"
    end
    
    it "should not be valid" do
      page.should have_content "too many characters"
    end
    
    it "should not be saved" do
      Comment.all.count.should == 0
    end
    
  end
  
end
