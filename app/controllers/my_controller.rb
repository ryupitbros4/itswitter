# -*- coding: utf-8 -*-
class MyController < ApplicationController

  #before_action :authenticate_user!

  def index
    set_crowded_consts
    @u_id = params[:u_id]
    @my = User.find(@u_id)
    @postit = @my.comments
    @mycomments = Comment.where(user_id: @my.id)
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    @how_crowded = ["席がガラガラ","席が半分埋まってる","席がほぼ埋まってる","席に座れない人がいる","席に座れない人がかなりいる","CLOSE","記録なし"]
  end

  def my_log
    @my = User.find(params[:uid])
    if params[:category] == '0'
      @category = "がいいねした"
      @list = @my.comments
    else
      @category = "の投稿"
      @list = Comment.where(user_id: @my.id)
    end
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    @how_crowded = ["席がガラガラ","席が半分埋まってる","席がほぼ埋まってる","席に座れない人がいる","席に座れない人がかなりいる","CLOSE","記録なし"]
  end

  def favorites
    set_crowded_consts
    @my = User.find(session[:user_id])
    @how_crowded = ["席がガラガラ","席が半分埋まってる","席がほぼ埋まってる","席に座れない人がいる","席に座れない人がかなりいる","CLOSE","記録なし"]
  end

  def follow
    unless current_user.restaurants.include?(Restaurant.find(params[:restaurant_id]))
      current_user.restaurants << Restaurant.find(params[:restaurant_id])
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'my/follow', locals: { restaurant: Restaurant.find(params[:restaurant_id]) } }
    end
  end

  def unfollow
    if current_user.restaurants.include?(Restaurant.find(params[:restaurant_id]))
      current_user.restaurants.destroy(params[:restaurant_id])
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'my/unfollow', locals: { restaurant: Restaurant.find(params[:restaurant_id]) } }
    end
  end
end
