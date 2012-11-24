class ResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.send_email("reset")
    end
    redirect_to root_url, :notice => "An email has been sent to #{params[:email]} with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
    if !@user
      redirect_to root_url, :notice => "The requested page does not exist."
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :notice => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      if params[:remember_me]
        sign_in(user, true)
      else
        sign_in(user, false)
      end
      user.send_email("successful")
      redirect_to current_user, :notice => "Welcome back #{@user.first_name} #{@user.last_name}, your password has been reset."
    else
      render 'edit'
    end
  end
end
