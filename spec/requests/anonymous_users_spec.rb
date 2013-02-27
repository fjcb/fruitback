require 'spec_helper'

describe "anonymous user" do
  
  before do
    
    @user = User.create! name: "A user", email: "user@example.com"
    @customer = User.create! name: "A customer", email: "customer@example.com", customer: true
    
    @site = Site.new name: "A site"
    @site.user_id = @customer.id
    @site.save
    
    @idea = Idea.new title: "An idea", description: "A user's idea."
    @idea.site_id = @site.id
    @idea.user_id = @user.id
    @idea.save
    
    @comment = Comment.new text: "A user's comment."
    @comment.user_id = @user.id
    @comment.idea_id = @idea.id
    @comment.save
    
  end
  
  describe "creates idea" do
      
      before do
        visit site_path(@site)
        
        fill_in('idea_title', :with => "Funky idea")
        fill_in('idea_description', :with => 'Description of my funky idea.')
        
        click_on "Post idea"
      end
      
      it "shows the idea" do
        
        page.should have_content "Funky idea"
        page.should have_content "Description of my funky idea."
        
      end
      
      it "has a session" do
        
        page.should have_content "Logged in as Anonymous"
        
      end
      
      it "is saved as anonymous user" do

        User.last.name.should == "Anonymous"
        
      end
      
  end
  
  describe "creates comment" do
      
      before do
        
        visit site_idea_path(@site, @idea)
        
        fill_in('comment_text', :with => 'Description of my comment.')
        
        click_on "Post comment"
      end
      
      it "shows the comment" do
        
        page.should have_content "Description of my comment."
        
      end
      
      it "is saved" do

        Comment.last.text.should == "Description of my comment."
        
      end
      
  end
end
