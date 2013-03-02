class Site < ActiveRecord::Base
  attr_accessible :name, :url
  
  belongs_to :user
  
  has_many :ideas, :dependent => :delete_all
  
  validates :name, presence: true, length: { maximum: 50 } 
  
end
