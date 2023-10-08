class UsersController < ApplicationController

  def show
    @name = User.find(params[:id])
    @items = @name.items
  end

end
