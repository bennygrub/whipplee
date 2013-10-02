class Post < ActiveRecord::Base
  attr_accessible :content, :publish, :title, :video, :image, :image_cache
  belongs_to :user

  mount_uploader :image, ImageUploader

  acts_as_taggable
  acts_as_taggable_on :type, :site

end
