class CommentsController < ApplicationController
  before_filter :load_yardsale, :only => [:create, :destroy]

  def index
    if !current_user.admin?
      redirect_to current_user
    else
      @title = "All comments"
      @comments = Comment.all
    end
  end

  def show
    @comments = current_user.comments.all
  end

  def create
    @comment = current_user.comments.build(params[:comment])
    @comment.yardsale = @yardsale
    if @comment.save
      flash[:notice] = "Comment was added."
    else
      flash[:notice] = "Unable to add comment."
    end
    redirect_to @yardsale
  end

  def destroy
    @comment = @yardsale.comments.find(params[:id])
    @comment.destroy
    redirect_to @yardsale, :notice => "Comment was deleted."
  end

  private

    def load_yardsale
      @yardsale = Yardsale.find(params[:yardsale_id])
    end
end
