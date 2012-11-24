class CategoriesController < ApplicationController
  before_filter :check_existence, :only => :show
  before_filter :authorized_user, :only => :destroy
  
  def index
    @categories = Category.paginate(:page => params[:page], :per_page => 13)
  end

  def show
  end

  def destroy
    @category = Category.find_by_name(params[:id])
    @categorising = Categorising.all
    
    @categorising.each do |category|
      if category.category_id == @category.id
        category.destroy
      end
    end

    @category.destroy
    redirect_to categories_url, :notice => "Category #{@category.name} was deleted."
  end

  private

    def check_existence
      @category = Category.find_by_name(params[:id])
      if !@category
        redirect_to current_user, :notice => "category #{params[:id]} does not exist."
      end
    end

    def authorized_user
      if !current_user.admin?
        redirect_to current_user
      end
    end
end
