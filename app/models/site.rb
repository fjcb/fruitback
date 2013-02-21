class Site < ActiveRecord::Base
  attr_accessible :name, :url
  
  belongs_to :user
  
  has_many :ideas
  
end
