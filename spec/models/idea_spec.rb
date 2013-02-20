require 'spec_helper'

describe Idea do
  before do
    @site = Site.new name: "Bananinator", url: "http://bananinator.com"
    @idea = Idea.new title: "New idea", description: "I have an idea..."
    @site.save
    @idea.save
    @idea.update_attribute :site_id, @site.id
  end
  
  describe "idea has site" do
    let(:idea) { Idea.find(@idea.id) }
    specify { idea.site.should == @site }
  end
end
