class PublicPagesController < ApplicationController
  def about
  end

  def contact
  end

  def help
  end

  def home
    if signed_in?
      redirect_to current_user
    end
  end

  def search
    if params[:search].present?
      @yardsales = Yardsale.search(params[:search]).paginate(page: params[:page], :per_page => 5)
    end
  end
end
