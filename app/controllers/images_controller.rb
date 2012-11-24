class ImagesController < ApplicationController
  before_filter :load_yardsale,   :only => [:create, :destroy]
  before_filter :authorized_user, :only   => :destroy

  def index
    @images = Image.paginate(:page => params[:page], :per_page => 20)
  end

  def create
    @image = @yardsale.images.build(params[:image])
    if @image.save
      flash[:notice] = "Image was uploaded."
    else
      flash[:notice] = "Could not upload image."
    end
    redirect_to @yardsale
  end

  def destroy
    @image = Image.find_by_id(params[:id])
    @image.destroy
    redirect_to @yardsale, :notice => "Image was deleted."
  end

  private

    def load_yardsale
      @yardsale = Yardsale.find(params[:yardsale_id])
    end

    def authorized_user
      @yardsale = current_user.yardsales.find_by_id(params[:yardsale_id])
      if !current_user.admin? && !current_user?(@yardsale.user)
        redirect_to current_user, :notice => "image with id #{params[:id]} doesn't belong to you, you can only delete your images."
      end
    end
end
