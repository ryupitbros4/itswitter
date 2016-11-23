class MyController < ApplicationController

  before_action :authenticate_user!

  def favorite
    @my = User.find(session[:user_id])
  end
end
