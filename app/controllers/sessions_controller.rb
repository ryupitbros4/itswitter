# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth(auth)

    user.update(image_url: auth[:info][:image])
    
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
