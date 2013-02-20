require 'spec_helper'

describe "IdeaPages" do
  
  before do
    @site = Site.new name: "Bananinator", url: "bananinator.com"
    @idea = Idea.new title: "New idea", description: "I have an idea..."
    @site.save
    @idea.save
    @idea.update_attribute :site_id, @site.id
  end
  
  describe "site has ideas" do
    let(:idea) { Idea.find(@idea.id) }
    specify { idea.site.should == @site }
  end
  
  describe "site" do
    
    let(:idea) { Idea.find(@idea.id) }
    
    it "has ideas" do
      idea.site.should == @site
    end

    it "shows ideas" do
      visit site_ideas_path(@site, idea)
      page.should have_selector "h1", text: "New idea"
    end
  
    
  end
  
  
end
