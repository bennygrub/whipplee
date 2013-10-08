class Post < ActiveRecord::Base
  attr_accessible :content, :publish, :title, :video, :image, :image_cache, :type_list, :site_list
  belongs_to :user
  has_many :favorites
  
  mount_uploader :image, ImageUploader

  acts_as_taggable
  acts_as_taggable_on :type, :site

end
