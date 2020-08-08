class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  mount_uploader :user_image, ImageUploader
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :like_posts, through: :likes, source: :post

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  
  has_many :followings, through: :active_relationships, source: :follower
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  
  has_many :followers, through: :passive_relationships, source: :following
  
  def followed_by?(user)
    
    passive_relationships.find_by(following_id: user.id).present?
  end


end
