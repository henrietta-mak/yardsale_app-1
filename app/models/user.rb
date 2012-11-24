class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username, :email, :address_attributes, :password, :password_confirmation

  has_secure_password

  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address
  has_many :yardsales, :dependent => :destroy
  has_many :relationships, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  before_create { create_remember_token(:remember_token) }
  before_validation :downcase_data

  validates :first_name,            :presence   => true,
                                    :length     => {:in => 2..15},
                                    :uniqueness => {:case_sensitive => false},
                                    :exclusion  => {:in => ['admin', 'root']}
  validates :last_name,             :presence   => true,
                                    :length     => {:in => 2..15},
                                    :uniqueness => {:case_sensitive => false},
                                    :exclusion  => {:in => ['admin', 'root']}
  validates :username,              :presence   => true,
                                    :length     => {:in => 3..20},
                                    :format     => {:with => /\A\w+\Z/}, 
                                    :uniqueness => {:case_sensitive => false},
                                    :exclusion  => {:in => ['admin', 'root']}
  validates :email,                 :presence   => true,
                                    :format     => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, 
                                    :uniqueness => {:case_sensitive => false}
  validates :password,              :presence   => true,
                                    :length     => {:minimum => 6}, :on => :create,
                                    :format     => {:with => /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/,
                                                    :message => "password has to contain at least 1 letter and 1 number"}
  validates :password_confirmation, :presence   => true, :on => :create

  def to_param
    username
  end

  def send_email(type)
    if type == "reset"
      create_remember_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!
      Mailer.password_reset(self).deliver
    elsif type == "successful"
      Mailer.successful_reset(self).deliver
    elsif type == "greet"
      Mailer.user_greet(self).deliver
    else
      Mailer.user_good_bye(self).deliver
    end
  end

  private

    def create_remember_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

    def downcase_data
      self.first_name.downcase!
      self.last_name.downcase!
      self.username.downcase!
      self.email.downcase!
    end
end
