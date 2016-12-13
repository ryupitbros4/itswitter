class MyController < ApplicationController

  before_action :authenticate_user!

  def index
    set_crowded_consts
    @my = User.find(session[:user_id])
  end

  def favorites
    set_crowded_consts
    @my = User.find(session[:user_id])
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
