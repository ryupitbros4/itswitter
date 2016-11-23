class MyController < ApplicationController

  before_action :authenticate_user!

  def favorites
    set_crowded_consts
    @my = User.find(session[:user_id])
  end

  def follow
    unless current_user.restaurants.include?(Restaurant.find(params[:restaurant_id]))
      current_user.restaurants << Restaurant.find(params[:restaurant_id])
    end
    redirect_to :back
  end

  def unfollow
    if current_user.restaurants.include?(Restaurant.find(params[:restaurant_id]))
      current_user.restaurants.destroy(params[:restaurant_id])
    end
    redirect_to :back
  end
end
