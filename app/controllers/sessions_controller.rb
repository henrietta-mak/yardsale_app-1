class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_username(params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if params[:remember_me]
        sign_in(@user, true)
      else
        sign_in(@user, false)
      end
      redirect_to @user, :notice => "Welcome back #{@user.first_name} #{@user.last_name}"
      session.delete(:return_to)
    else
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url, :notice => "Logged out"
  end
end
