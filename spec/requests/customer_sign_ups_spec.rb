require 'spec_helper'

describe "customer" do
  
  describe "signs up" do
    
    let(:email) { ('a'..'z').to_a.shuffle[0..19].join + "@test.de" }
    
    before do 
      visit new_user_registration_path
      
      fill_in('Name', :with => "Customer")
      fill_in('Email', :with => email)
      fill_in('Password', :with => '12345678')
      fill_in('Password confirmation', :with => '12345678')
      
      click_on "Sign up"
    end
    
    it "should be customer" do  
      User.find_by_email(email).customer.should == true;
    end
    
    it "can create new site" do
      page.should have_content "Create new site"     
    end
  
    it "can see first steps" do
      page.should have_content "First steps"
    end  
  
  end
  
end
