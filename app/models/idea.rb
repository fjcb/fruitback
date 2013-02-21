class Idea < ActiveRecord::Base
  attr_accessible :description, :score, :title, :user_id, :site_id
  
  belongs_to :user
  
  belongs_to :site
  
end
