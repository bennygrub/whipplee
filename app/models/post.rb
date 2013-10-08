class Post < ActiveRecord::Base
  attr_accessible :content, :publish, :title, :video, :image, :image_cache, :type_list, :site_list
  belongs_to :user
  has_many :favorites
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  mount_uploader :image, ImageUploader

  acts_as_taggable
  acts_as_taggable_on :type, :site

  def self.followed_by(user)
    following_ids = %(SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id)
    where("user_id IN (#{following_ids}) OR user_id = :user_id",
          { :user_id => user })
  end
end
