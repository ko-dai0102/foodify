class UsersController < ApplicationController
  before_action :user_set, only: [:show, :liked_items]

  def show
    @items = @user.items
  end

  def edit_icon
  end

  def update_icon
    if current_user.update(icon_params)
      redirect_to user_path(current_user)
    else
      render :edit_icon
    end
  end

  def edit_name
    @user = current_user
  end

  def update_name
    @user = current_user
    if @user.update(name_params)
      redirect_to user_path(current_user)
    else
      render :edit_name
    end
  end

  def liked_items
    @liked_items = Like.where(user_id: @user.id).map(&:item)
  end

  private

  def user_set
    @user = User.find(params[:id])
  end

  def icon_params
    params.require(:user).permit(:icon)
  end

  def name_params
    params.require(:user).permit(:name)
  end

end
