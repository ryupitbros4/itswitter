class MyController < ApplicationController

  before_action :authenticate_user!

  def favorites
    set_crowded_consts
    @my = User.find(session[:user_id])
  end

  def follow
    current_user.restaurants << Restaurant.find(params[:restaurant_id])
    redirect_to :back
  end

  def unfollow
    current_user.restaurants.destroy(params[:restaurant_id])
    redirect_to :back
  end
end
