class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @relationship = current_user.relationships.build(:yardsale_id => params[:yardsale_id])
    if @relationship.save
      flash[:notice] = "You are now following #{params[:yardsale_id]}."
    else
      flash[:notice] = "Could not follow #{params[:yardsale_id]}."
    end
    redirect_to Yardsale.find_by_id(params[:yardsale_id])
  end

  def destroy
    @relationship = Relationship.find_by_id(params[:id])
    @relationship.destroy
    redirect_to current_user, :notice => "You have unfollowed #{params[:yardsale_id]}."
  end
end
