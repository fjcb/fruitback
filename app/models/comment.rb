class Comment < ActiveRecord::Base
  attr_accessible :text
  
  belongs_to :user
  attr_accessible :user_id
  
  belongs_to :idea
  attr_accessible :idea_id
  
end
