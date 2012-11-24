class Yardsale < ActiveRecord::Base
  attr_accessible :title, :date, :begin_time, :end_time, :address_attributes, :description

  belongs_to :user
  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address
  has_many :relationships, :dependent => :destroy
  has_many :categorisings, :dependent => :destroy
  has_many :categories, :through => :categorisings
  has_many :images, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  validates :user_id,    :presence => true
  validates :title,      :presence => true,
                         :length   => {:in => 2..100}
  validates :date,       :presence => true
  validates :begin_time, :presence => true
  validates :end_time,   :presence => true

  default_scope :order => 'yardsales.created_at DESC'

  def to_param
    "#{id}_#{title.downcase.gsub(/\W/, " ")}"
  end

  private

    def self.search(search)
      if search
        where('title LIKE ?', "%#{search}%")
      else
        scoped
      end
    end
end
