class Address < ActiveRecord::Base
  attr_accessible :user_id, :yardsale_id, :street, :city, :state, :zip_code
  
  belongs_to :user
  belongs_to :yardsale

  before_validation :downcase_data
  after_validation :geocode, :if => :address_changed?

  validates :street,   :presence => true
  validates :city,     :presence => true
  validates :state,    :presence => true
  validates :zip_code, :presence => true

  geocoded_by :address

  private

    def downcase_data
      self.street.downcase!
      self.city.downcase!
      self.state.downcase!
    end

    def address
      "#{street},#{city},#{state}"
    end

    def address_changed?
      attrs = %w(street city state)
      attrs.any?{|address| send "#{address}_changed?"}
    end
end
