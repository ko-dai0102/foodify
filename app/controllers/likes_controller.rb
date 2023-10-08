class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    @like = Like.new(user_id: current_user.id, item_id: @item.id)
    @like.save
    render partial: 'items/like', locals: { item: @item }
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, item_id: @item.id)
    @like.destroy
    render partial: 'items/like', locals: { item: @item }
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

end
