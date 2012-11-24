class YardsalesController < ApplicationController
  before_filter :signed_in_user,  :except => :show
  before_filter :check_existence, :only   => [:show, :edit, :update]
  before_filter :correct_user,    :only   => [:edit, :update]
  before_filter :authorized_user, :only   => :destroy

  def index
    if !current_user.admin?
      redirect_to current_user
    else
      @yardsales = Yardsale.paginate(:page => params[:page], :per_page => 13)
    end
  end

  def show
  end

  def new
    @yardsale = current_user.yardsales.build
  end

  def create
    @yardsale = current_user.yardsales.build(params[:yardsale])
    if @yardsale.save
      redirect_to @yardsale, :notice => "#{@yardsale.title} was created."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @yardsale.update_attributes(params[:yardsale])
      redirect_to @yardsale, :notice => "#{@yardsale.title} was updated."
    else
      render 'edit'
    end
  end

  def destroy
    @yardsale.destroy
    redirect_to current_user, :notice => "#{@yardsale.title} was deleted."
  end

  def following_users
    @relationships = Relationship.where(:yardsale_id => params[:yardsale_id]).paginate(:page => params[:page], :per_page => 13)
    render 'show_followers'
  end

  private

    def check_existence
      @yardsale = Yardsale.find_by_id(params[:id])
      if !@yardsale
        redirect_to current_user, :notice => "Yardsale with id #{params[:id]} does not exist."
      end
    end

    def correct_user
      @yardsale = current_user.yardsales.find_by_id(params[:id])
      if !@yardsale
        redirect_to current_user, :notice => "Yardsale with id #{params[:id]} doesn't belong to you, you can only edit your yardsales."
      end
    end

    def authorized_user
      @yardsale = current_user.yardsales.find_by_id(params[:id])
      if !current_user.admin? && !current_user?(@yardsale.user)
        redirect_to current_user, :notice => "Yardsale with id #{params[:id]} doesn't belong to you, you can only delete your yardsales."
      end
    end
end
