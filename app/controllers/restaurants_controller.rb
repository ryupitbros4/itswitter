# -*- coding: utf-8 -*-
class RestaurantsController < ApplicationController
  
  before_action :set_restaurants, only: [:report, :deliver]
  before_action :authenticate_user!, only: [:report, :deliver]

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
    set_crowded_consts
    #@len_num = @rank.count
  end
  
  def search
    escaped = params[:name].gsub('\\', '\\\\\\\\').gsub('%', '\%').gsub('_', '\_')    
    
    if escaped.blank?
      #flash[:warning] = '店名を入力してください'
      redirect_to :root, :alert => '店名を入力して下さい'
    end
    
    @searched = Restaurant.where("name like ? or hurigana like ?", "%#{escaped}%", "%#{escaped}%")
    set_crowded_consts
    
    if @searched.empty?
      @error = "検索ワードがヒットしませんでした。もう一度入れなおして下さい。"
    end
    
  end
  
  def report
    #ログイン、usersテーブルのuserデータの有無を確認。
    if logged_in? and User.where(:id => session[:user_id]).present?
      user_info = User.find(session[:user_id])
      if user_info.comments.present?
        informTime = user_info.comments.order(updated_at: :desc).limit(1).first
        if (Time.zone.now - informTime.updated_at).to_i < 60*3
          flash[:alert] = session[:nickname] + 'さんの次の情報更新まで' + (180 - (Time.zone.now - informTime.updated_at).to_i).to_s + '秒掛かります'
          redirect_to :root and return
        end
      end
    else
      redirect_to :root and return
    end

    #resnameはトップからlink_toで飛んできた値
    @restaurant_id = Restaurant.find_by(id: params[:resname])
    #restaurantidがnilだった場合は指定なし、そうでない場合は指定ありで初期値が設定される
    if @restaurant_id.nil? then
      @restaurant = Restaurant.new()
    else
      @restaurant = Restaurant.new(:id => @restaurant_id.id)
    end
  end
  
  def user_ranking
    user_rank = User.order("point DESC")
    @up_rank = user_rank.limit(30)
    
    if !(session[:user_id].blank?)
      your_info = User.find(session[:user_id])
      your_index = 0
      user_rank.each_with_index do |usrank,index|
        if usrank.uid == your_info.uid
          your_index = index
        end
      end
      scope = 3
      if your_index  <= 0
        your_index =  1
        scope = 2
      end
      one_up_your_rnk = your_index - 1
      @your_rank = user_rank.limit(scope).offset(one_up_your_rnk)
    end
  end
  
  def deliver
    #ログイン、usersテーブルのuserデータの有無を確認。
    if logged_in? and User.where(:id => session[:user_id]).present?
      id = params[:restaurant][:id]
      user_info = User.find(session[:user_id])
      if user_info.comments.present?
        informTime = user_info.comments.order(updated_at: :desc).limit(1).first
        if (Time.zone.now - informTime.updated_at).to_i < 60*3
          flash[:alert] = session[:nickname] + 'さんの次の情報更新まで' + (180 - (Time.zone.now - informTime.updated_at).to_i).to_s + '秒掛かります'
          redirect_to :report_restaurants and return
        end
      end
    else
      redirect_to :root and return
    end

    if id.blank?
      #flash[:warning] = '店名を選択して下さい'
      redirect_to :report_restaurants, :alert => '店名を選択して下さい' and return
    end
    
    if params[:restaurant][:crowdedness].blank?
      #flash[:warning] = '混雑度を選択して下さい'
      redirect_to :report_restaurants, :alert => '混雑度を選択して下さい' and return
    end
    
    
    restaurant = Restaurant.find(id)
    crowd = params[:restaurant][:crowdedness]
    if crowd.blank?
      #flash[:warning] = '店の混雑度を選択して下さい'
      redirect_to :report_restaurants, :alert => '店の混雑度を選択して下さい' and return
    end
    
    Restaurant.transaction do
      Comment.create({ crowdedness: crowd, user_id: session[:user_id], restaurant_id: restaurant.id, comment: params[:restaurant][:latest_comment] })
      restaurant.save!
      restaurant.touch
      #混雑状況を伝えたらユーザーのポイントを+10
      add_report_point()
    end
    redirect_to action: 'comment_log', restaurant_id: id
  end

  def comment_log
    if params[:restaurant_id].present?
      restaurant = Restaurant.find(params[:restaurant_id])
      @restaurant_name = restaurant.name
      @comments = restaurant.comments.order(updated_at: :desc)
    else
      @restaurant_name = '飲食店'
      @comments = Comment.all
    end
    set_crowded_consts
  end

  private

  def set_restaurants
    #五十音順で並び替えてnameとidを渡す
    @restaurant_names = Restaurant.all.restaurant_order_hurigana.pluck(:name, :id)
  end
  
  def add_report_point
    current_user ||= User.find(session[:user_id])
    current_user.point = current_user.point + 10
    current_user.save!
  end
  
  def treatment
  end

end
