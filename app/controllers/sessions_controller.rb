class SessionsController < ApplicationController
  def create

    s = Session.new create_params
    s.validate
    render_resource s
    session[:current_user_id]=s.user.id

  end

  def destory

  end

  def create_params
    params.permit(:email, :password)
  end
end
