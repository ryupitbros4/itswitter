# -*- coding: utf-8 -*-
class InvestigatorsController < ApplicationController

  def index
    @restaurants = Restaurant.order('id')
  end

  def update
    restaurant = Restaurant.find(params[:id])
    restaurant.num_people = params[:congestion]
    restaurant.seats_occ = ((restaurant.num_people.to_f/restaurant.num_seats.to_f)*100).round
    restaurant.save
    redirect_to :investigators_index
  end

  def new
    @investigator = Restaurant.new
  end

  def create
    new_rest = params.require(:restaurant).permit(:name, :hurigana, :num_seats)
    @investigator = Restaurant.new(new_rest)
    begin
      Restaurant.transaction do
        @investigator.save!
        renewal = Renewal.new({ update_info: "新たなお店 「#{new_rest[:name]}」 が追加されました", restaurant_id: @investigator.id })
        renewal.save!
        redirect_to :investigators_index
      end
    rescue => e
      logger.error e.backtrace.join("\n")
      flash[:warning] = "お店の新規登録に失敗しました。"
      render 'new'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to :investigators_delete
  end

  def delete
    @restaurants = Restaurant.all
  end

end
