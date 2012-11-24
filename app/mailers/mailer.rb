class Mailer < ActionMailer::Base
  default :from => "noreply@yardsalemail.com"

  def user_greet(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to YardSale - get started now!"
  end

  def user_good_bye(user)
    @user = user
    mail :to => user.email, :subject => "You have deactivated your YardSale account"
  end
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "YardSale Password Reset"
  end

  def successful_reset(user)
    @user = user
    mail :to => user.email, :subject => "YardSale Password Reset Confirmation"
  end
end
