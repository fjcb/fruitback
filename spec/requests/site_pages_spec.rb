require 'spec_helper'

describe "site page" do
  
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
    
  end
  
  describe "for visitor" do
    
    it "shows idea" do
      visit site_path(@site)
      page.should have_content "The idea"
    end
  
  end
  
  describe "for customer" do
    
    it "shows idea" do
      visit customer_site_path(@site)
      page.should have_content "The idea"
    end
  
  end
  
  describe "for widget" do
    
    it "shows idea" do
      visit micro_site_path(@site)
      page.should have_content "The idea"
    end
  
  end
  
end
