require 'spec_helper'

describe "anonymous user" do
  
  before do
    @site = Site.new name: "Bananinator", url: "http://bananinator.com"
    @site.save
  end
  
  describe "creates idea" do
      
      it "shows idea" do
        visit site_ideas_path(@site)
        
        fill_in('Title', :with => "Funky idea")
        fill_in('Description', :with => 'Description of my funky idea.')
        
        click_on "Create Idea"
        
        page.should have_content "Funky idea"
        
        click_link "Funky idea"
        
        page.should have_content "Funky idea"
        
        page.should have_content "Description of my funky idea."
        
        page.should have_content "Logged in as Anonymous"
        
      end
      
      describe "has a session" do
        
      end
      
      describe "is saved as anonymous user" do
        
      end
      
  end
  
end
