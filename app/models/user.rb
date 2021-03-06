class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :name, :admin, :avatar_cache, :remove_avatar
  # attr_accessible :title, :body
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :posts
  has_many :favorites
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  mount_uploader :avatar, AvatarUploader

  after_create :new_user_email

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  def friend_feed
    Post.from_users_followed_by(self)
  end

  def new_user_email
    UserMailer.new_user_signup(self).deliver
  end

end
