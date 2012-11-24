class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :categorising, :dependent => :destroy
  has_many :yardsales, :through => :categorising

  before_validation :downcase_data

  validates :name, :presence   => true,
                   :length     => {:in => 1..30},
                   :format     => {:with => /\A\w+\Z/}

  def to_param
    name
  end

  private

    def downcase_data
      self.name.downcase!
    end
end
