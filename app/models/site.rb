class Site < ActiveRecord::Base
  attr_accessible :name, :url
  
  has_many :ideas
  
end
