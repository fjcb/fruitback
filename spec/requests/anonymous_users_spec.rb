require 'spec_helper'

describe "anonymous user" do
  
  before do
    
    @site = Site.new name: "Bananinator", url: "http://bananinator.com"
    @user = User.create name: "Customer", email: "user@example.com", customer: true
    @site.user_id = @user.id
    @site.save

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
        
        @idea = Idea.create title: 'Funky idea', description: 'Description of my funky idea.'
        @site.ideas.push(@idea)
        @site.save
        
        visit site_idea_path(@site, @idea)
        
        fill_in('comment_text', :with => 'Description of my comment.')
        
        click_on "Post comment"
      end
      
      it "shows the comment" do
        
        page.should have_content "Description of my comment."
        
      end
      
      it "is saved" do

        Comment.last.description.should == "Description of my comment."
        
      end
      
  end
end
