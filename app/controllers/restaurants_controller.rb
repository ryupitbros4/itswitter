# -*- coding: utf-8 -*-
class RestaurantsController < ApplicationController

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
    @searched = Restaurant.where("name like '%" + escaped + "%'" + "or hurigana like '%" + escaped + "%'")
    if @searched.empty?
      @error = "検索ワードがヒットしませんでした。もう一度入れなおして下さい。"
    end
  end

end
