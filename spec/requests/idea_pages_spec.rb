require 'spec_helper'

describe "IdeaPages" do
  
  before do
    @site = Site.new name: "Bananinator", url: "http://bananinator.com"
    @site.save
    @user = User.new email: "user@example.com", password: "useruser"
    @user.save
    @idea = Idea.new title: "New idea", description: "I have an idea...", site_id: @site.id, user_id: @user.id
    @idea.save
  end
  
  describe "site" do
    
    let(:idea) { Idea.find(@idea.id) }
    
    it "has ideas" do
      idea.site.should == @site
    end

    it "shows idea" do
      visit site_idea_path(@site, idea)
      page.should have_selector "h1", text: "New idea"
    end
  
    
  end
  
  
end
