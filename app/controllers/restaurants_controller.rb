# -*- coding: utf-8 -*-
class RestaurantsController < ApplicationController
  
  before_action :set_restaurants, only: [:report, :deliver]

  def slide_info
    @renewals = Renewal.order("created_at desc").limit(10)
    render :layout => false
  end
  
  def index
    @restaurants = Restaurant.all
    @new_restaurants = Restaurant.where('created_at > ?', params[:from] ? params[:from] : 30.days.ago).order(created_at: :desc)
    @per_array = Array.new
    
    #占有率が低い順に並び替える
    @rank=Restaurant.order_by_crowdedness

    @how_crowded = ["席がガラガラ","席が半分埋まってる","席がほぼ埋まってる","席に座れない人がいる","席に座れない人がかなりいる","CLOSE","記録なし"]
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    #@len_num = @rank.count
  end
  
  def search
    escaped = params[:name].gsub('\\', '\\\\\\\\').gsub('%', '\%').gsub('_', '\_')    
    
    if escaped.blank?
      flash[:warning] = '店名を入力してください'
      redirect_to :root
    end
    
    @searched = Restaurant.where("name like ? or hurigana like ?", "%#{escaped}%", "%#{escaped}%")
    @how_crowded = ["席がガラガラ","席が半分埋まってる","席がほぼ埋まってる","席に座れない人がいる","席に座れない人がかなりいる","CLOSE","記録なし"]
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    
    if @searched.empty?
      @error = "検索ワードがヒットしませんでした。もう一度入れなおして下さい。"
    end
    
  end
  
  def report
    #resnameはトップからlink_toで飛んできた値
    @restaurant_id = Restaurant.find_by(name: params[:resname])
    #restaurantidがnilだった場合は指定なし、そうでない場合は指定ありで初期値が設定される
    if @restaurant_id.nil? then
      @restaurant = Restaurant.new()
    else
      @restaurant = Restaurant.new(:id => @restaurant_id.id)
    end
  end
  
  def deliver
    id = params[:restaurant][:id]
    
    if id.blank?
      flash[:warning] = '店名を選択して下さい'
      redirect_to :report_restaurants and return
    end
    
    if params[:restaurant][:crowdedness].blank?
      flash[:warning] = '混雑度を選択して下さい'
      redirect_to :report_restaurants and return
    end
    
    restaurant = Restaurant.find(id)
    crowd = params[:restaurant][:crowdedness]
    if crowd.blank?
      flash[:warning] = '店の混雑度を選択して下さい'
      redirect_to :report_restaurants and return
    end
    restaurant.crowdedness = crowd
    Restaurant.transaction do
      restaurant.save!
      restaurant.touch
    end
    redirect_to :root
  end

  private
  
  def set_restaurants
    #五十音順で並び替えてnameとidを渡す
    @restaurant_names = Restaurant.all.restaurant_order_hurigana.pluck(:name, :id)
  end
end
