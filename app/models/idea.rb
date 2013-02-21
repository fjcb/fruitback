class Idea < ActiveRecord::Base
  attr_accessible :description, :score, :title, :user_id, :site_id
  
  belongs_to :user
  
  belongs_to :site
  
  def can_be_edited?
    Time.now < created_at + 60*5
  end
  
  def edited?
    updated_at > created_at
  end
  
end
