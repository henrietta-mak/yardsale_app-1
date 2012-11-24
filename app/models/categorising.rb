class Categorising < ActiveRecord::Base
  attr_accessible :category_id

  belongs_to :yardsale
  belongs_to :category

  validates :yardsale_id, :presence => true
  validates :category_id, :presence => true
end
