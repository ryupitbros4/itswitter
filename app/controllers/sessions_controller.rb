class SessionsController < ApplicationController
  def create

    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    reset_session
    session[:user_id] = user.id
    session[:nickname] = user.nickname
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    flash[:warning] = "Twitter認証に失敗しました。"
    redirect_to root_path
  end
end
