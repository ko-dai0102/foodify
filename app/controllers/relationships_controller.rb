class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    follow = current_user.active_relationships.new(follower_id: params[:user_id])
    follow.save
    render partial: "users/follow", locals: { user: @user }
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    render partial: "users/follow", locals: { user: @user }
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
