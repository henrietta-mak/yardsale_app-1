class Relationship < ActiveRecord::Base
  attr_accessible :yardsale_id

  belongs_to :user
  belongs_to :yardsale

  validates :user_id,     :presence => true
  validates :yardsale_id, :presence => true
end
