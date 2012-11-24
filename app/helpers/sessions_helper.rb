module SessionsHelper
  def sign_in(user, remember)
    if remember == true
      cookies.permanent[:remember_token] = user.remember_token
    else
      cookies[:remember_token] = user.remember_token
    end
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if cookies[:remember_token]
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    if !signed_in?
      session[:return_to] = request.url
      redirect_to signin_url, :notice => "You must sign in."
    end
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
end
