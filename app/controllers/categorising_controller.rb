class CategorisingController < ApplicationController
  before_filter :load_yardsale

  def create
    @category = Category.find_or_create_by_name(params[:category][:name])
    if !Categorising.find_by_yardsale_id_and_category_id(@yardsale.id, @category.id)
      @categorising = @yardsale.categorisings.build(:category_id => @category.id)
      if @categorising.save
        flash[:notice] = "#{@category.name} was added."
      else
        flash[:notice] = "Unable to add #{@category.name}."
      end
    else
      flash[:notice] = "#{@category.name} already exists."
    end
    redirect_to @yardsale
  end

  def destroy
    @categorising = @yardsale.categorisings.find(params[:id])
    @categorising.destroy
    redirect_to @yardsale, :notice => "#{@categorising.category.name} was removed."
  end

  private

    def load_yardsale
      @yardsale = Yardsale.find(params[:yardsale_id])
    end
end
