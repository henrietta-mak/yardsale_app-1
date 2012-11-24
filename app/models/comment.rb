class Comment < ActiveRecord::Base
  attr_accessible :comment
  
  belongs_to :user
  belongs_to :yardsale

  validates :user_id,     :presence => true
  validates :yardsale_id, :presence => true
  validates :comment,     :presence => true,
                          :length   => {:in => 10..150}
end
