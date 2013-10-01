class Post < ActiveRecord::Base
  attr_accessible :content, :publish, :title, :video
  belongs_to :user
end
