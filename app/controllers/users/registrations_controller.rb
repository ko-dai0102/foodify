class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: [:update, :destroy]

  def check_guest
    if current_user.email == "test@test.com"
      redirect_to root_path
    end
  end
end
