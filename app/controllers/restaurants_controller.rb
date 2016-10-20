# -*- coding: utf-8 -*-
class RestaurantsController < ApplicationController
  
  before_action :set_restaurants, only: [:report, :deliver]

  def index
    @restaurants = Restaurant.all
    @per_array = Array.new
    
    @restaurants.each do |restaurant|
      #perは占有率
      per = ((restaurant.num_people.to_f/restaurant.num_seats.to_f)*100).round
      #モデルのseats_occに占有率を更新
      restaurant.seats_occ = per
      restaurant.save
    end
    #占有率が低い順に並び替える
    @rank=Restaurant.order('seats_occ')
    @len_num = @rank.count
  end

  def search
    escaped = params[:name].gsub('\\', '\\\\\\\\').gsub('%', '\%').gsub('_', '\_')
    @searched = Restaurant.where("name like ? or hurigana like ?", "%#{escaped}%", "%#{escaped}%")
    if @searched.empty?
      @error = "検索ワードがヒットしませんでした。もう一度入れなおして下さい。"
    end
  end
  
  def report
    @restaurant = Restaurant.new()
  end
  
  def deliver
    id = params[:restaurant][:id]
    if id.blank?
      flash[:warning] = '店名を選択して下さい'
      redirect_to :report_restaurants and return
    end
    restaurant = Restaurant.find(id)
    restaurant.crowdedness = params[:restaurant][:crowdedness]
    restaurant.save
    redirect_to :root
  end

  private

  def set_restaurants
    @restaurant_names = Restaurant.all.pluck(:name, :id)
  end

end
