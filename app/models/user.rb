class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :admin, :customer
  
  has_many :sites, :dependent => :delete_all
  
  has_many :ideas, :dependent => :delete_all
  
  has_many :comments, :dependent => :delete_all
  
  has_many :votes, :dependent => :delete_all
  
  has_many :responses, :dependent => :delete_all
  
  def visitor?
    !admin? && !customer?
  end
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :admin, presence: true, on: :save
  validates :customer, presence: true, on: :save
  
end
