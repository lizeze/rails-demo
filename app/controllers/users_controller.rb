class UsersController < ApplicationController
  def create
    user = User.create create_params
    render_resource user

  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end

  def me
    user = current_user
    if user.nil?
      head 404
    else
      render_resource user
    end
  end

end
