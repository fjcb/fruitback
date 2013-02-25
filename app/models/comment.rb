class Comment < ActiveRecord::Base
  attr_accessible :text
  
  belongs_to :user
  attr_accessible :user_id
  
  belongs_to :idea
  attr_accessible :idea_id
  
  validates :text, presence: true, length: { maximum: 1000 }, on: :save
  
end
