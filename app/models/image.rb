class Image < ActiveRecord::Base
  attr_accessible :yardsale_id, :image, :note, :remote_image_url

  belongs_to :yardsale

  validates :yardsale_id, :presence => true

  mount_uploader :image, ImageUploader
end
