require 'spec_helper'

describe "CustomerSignUps" do
  
  describe "user signs up" do
    
    let(:email) { ('a'..'z').to_a.shuffle[0..19].join + "@test.de" }
    
    it "user should be customer" do
      visit new_user_registration_path
      
      fill_in('Email', :with => email)
      fill_in('Password', :with => '12345678')
      fill_in('Password confirmation', :with => '12345678')
      
      click_on "Sign up"
      
      User.find_by_email(email).customer.should == true;
      
      page.should have_content "sites"     
    end  
  
  end
  
end