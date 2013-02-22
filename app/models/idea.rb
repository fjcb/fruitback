class Idea < ActiveRecord::Base
  attr_accessible :description, :score, :title
  
  belongs_to :user
  attr_accessible :user_id
  
  belongs_to :site
  attr_accessible :site_id
  
  has_many :comments
  
  def editable?
    Time.now < created_at + 60*10
  end
  
  def edited?
    updated_at > created_at
  end
  
end
