class Idea < ActiveRecord::Base
  attr_accessible :description, :title
  
  belongs_to :user
  attr_accessible :user_id
  
  belongs_to :site
  attr_accessible :site_id
  
  has_many :comments
  
  has_many :votes
  
  has_many :responses
  
  def editable?
    Time.now < created_at + 60*10
  end
  
  def edited?
    updated_at > created_at
  end
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  
  def score
    score = 0
    if votes
      votes.each { |vote|
        score += 1 #vote.score
      }
    end
    score
  end
  
end
