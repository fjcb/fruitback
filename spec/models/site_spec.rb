require 'spec_helper'

describe Site do
  before do
    @site = Site.new name: "Bananinator", url: "http://bananinator.com"
    @idea = Idea.new title: "New idea", description: "I have an idea..."
    @idea.save
    @site.ideas.push @idea
    @site.save
  end
  
  # integration test
  describe "site has idea" do
    let(:site) { Site.find(@site.id) }
    specify { site.ideas.should include @idea }
  end
  
  describe "when site name is empty" do
    before { @site.name = "" }
    it { should_not be_valid }
  end
  
end
