class Idea < ActiveRecord::Base
  attr_accessible :description, :score, :title
  
  belongs_to :user
  
end
