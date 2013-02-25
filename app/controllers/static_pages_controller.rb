class StaticPagesController < ApplicationController
  
  layout 'customer_site'
  
  def home
    @user = User.new
  end
  
  def about
  end
  
  def help
  end
  
end
