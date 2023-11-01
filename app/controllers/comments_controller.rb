class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_comments, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    render partial: "items/comments", locals: { item: @item, comments: @comments, comment: @comment }
    #redirect_to item_path(params[:item_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_comments
    @item = Item.find(params[:id])
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

end
