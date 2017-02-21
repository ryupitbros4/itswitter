# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

  #ベーシック認証
  def basic_auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV['BASIC_USER'] && pass == ENV['BASIC_PASSWORD']
    end
  end

  def set_crowded_consts
    @how_crowded = ["席ガラガラ","席が半分","埋まってる","外にも人が","長蛇の列","CLOSE","記録なし"]
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
  end

  def authenticate_user!
    redirect_to :root, flash: { alert: 'ログインして下さい' } unless !!session[:user_id]
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: 'ログインしてください'
  end
end
