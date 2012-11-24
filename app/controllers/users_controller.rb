class UsersController < ApplicationController
  before_filter :signed_in_user,  :only => [:index, :show, :edit, :update, :destroy, :followed_yardsales]
  before_filter :check_existence, :only => [:show, :edit, :update]
  before_filter :correct_user,    :only => [:edit, :update]
  before_filter :authorized_user, :only => :destroy

  def index
    if !current_user.admin?
      redirect_to current_user
    else
      @users = User.paginate(:page => params[:page], :per_page => 13)
    end
  end

  def show
    @user = User.find_by_username(params[:id])
    @yardsales = @user.yardsales.paginate(:page => params[:page], :per_page => 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user, false)
      @user.send_email("greet")
      redirect_to @user, :notice => "#{@user.first_name} #{@user.last_name}, Welcome to YardSale."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in(@user, false)
      redirect_to @user, :notice => "Your account has been updated."
    else
      render 'edit'
    end
  end

  def destroy
    @user.send_email("deactivate")
    @user.destroy
    if current_user.admin?
      redirect_to users_url, :notice => "#{@user.first_name} #{@user.last_name} was deleted."
    else
      redirect_to root_url, :notice => "Your account has been deleted."
    end
  end

  def followed_yardsales
    @relationships = Relationship.where(:user_id => current_user).paginate(:page => params[:page], :per_page => 13)
    render 'show_followed_yardsales'
  end

  def comments
    @title = "Comments"
    @comments = current_user.comments.paginate(:page => params[:page], :per_page => 13)
    render 'comments/index'
  end

  private

    def check_existence
      @user = User.find_by_username(params[:id])
      if !@user
        redirect_to current_user, :notice => "User #{params[:id]} does not exist."
      end
    end

    def correct_user
      @user = User.find_by_username(params[:id])
      if !current_user?(@user)
        redirect_to current_user, :notice => "You are not #{params[:id]}, you can only edit your account."
      end
    end

    def authorized_user
      @user = User.find_by_username(params[:id])
      if !current_user.admin? && !current_user?(@user)
        redirect_to current_user, :notice => "You are not #{params[:id]}, you can only delete your account."
      end
    end
end
