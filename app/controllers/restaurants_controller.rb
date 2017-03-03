# -*- coding: utf-8 -*-
class RestaurantsController < ApplicationController
  require 'open-uri'
  require 'uri'
  before_action :set_restaurants, only: [:report, :deliver]
  before_action :authenticate_user!, only: [:report, :deliver, :tell_index, :tell_search]

  #ぐるなびAPIからの店舗情報取得部分
  def shop_info
    @shop_name = params[:shop_name]
    url = URI.escape('http://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=69a41a8fdd47711370393fef44c97b0a&format=json&area=AREA200&name='+ @shop_name)
    res = open(url)
    code, message = res.status

    if code == '200'
      result = ActiveSupport::JSON.decode res.read
      #取得店舗が一つしかないとうまく行かなかったので条件分岐
      if !result["rest"].nil? && (result["total_hit_count"].to_i >= 2)
        result["rest"].first(1).each do |rest|
          rest.each{ |key, value|
            if value == {}
              rest[key] = "情報なし"
            end
          }
          if (rest["code"]["areaname_s"] == {}) || (rest["code"]["areaname_s"] == nil)
            rest["code"]["areaname_s"] = "情報なし"
          end
          @gnavi = { name: rest["name"], name_kana: rest["name_kana"], address: rest["address"], opentime: rest["opentime"], holiday: rest["holiday"],
          tel: rest["tel"], budget: rest["budget"], areaname: rest["code"]["areaname_s"], shop_image1: rest["image_url"]["shop_image1"], url: rest["url"], lat: rest["latitude"], lon: rest["longitude"] }
        end
      elsif result["total_hit_count"].to_i == 1
        result["rest"].each{ |key, value|
          if value == {}
            result["rest"][key] = "情報なし"
          end
        }
        if (result["rest"]["code"]["areaname_s"] == {}) || (result["rest"]["code"]["areaname_s"] == nil)
          result["rest"]["code"]["areaname_s"] = "情報なし"
        end
        @gnavi = { name: result["rest"]["name"], name_kana: result["rest"]["name_kana"], address: result["rest"]["address"],
        opentime: result["rest"]["opentime"], holiday: result["rest"]["holiday"], tel: result["rest"]["tel"],
        budget: result["rest"]["budget"], areaname: result["rest"]["code"]["areaname_s"], shop_image1: result["rest"]["image_url"]["shop_image1"], url: result["rest"]["url"], lat: result["rest"]["latitude"], lon: result["rest"]["longitude"] }
      end

    else
      @gnavi = nil
    end

    #フォローユーザー表示部分
    shop_id = params[:shop_id]
    restaurant_column = Restaurant.find(shop_id)
    @fav_users = restaurant_column.users

  end

  def tell_index
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
  end

  def tell_search
    tell_escaped = params[:name].gsub('\\', '\\\\\\\\').gsub('%', '\%').gsub('_', '\_')
    if tell_escaped.blank?
      redirect_to :tell_index, :alert => '店名を入力して下さい' and return
    end
    @tell_searched = Restaurant.where("name like ? or hurigana like ?", "%#{tell_escaped}%", "%#{tell_escaped}%")
    if @tell_searched.empty?
      redirect_to :tell_index, :alert => 'お店がヒットしませんでした' and return
    end
  end

  def slide_info
    @renewals = Renewal.order("created_at desc").limit(10)
    render :layout => false
  end

  def promotion
    render :layout => 'promotion'
  end
  
  #promotionからの説明ページ
  def slide_explain
    render :layout => 'promotion'
  end
  
  def index
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    @how_crowded = ["席ガラガラ","席が半分","埋まってる","外にも人が","長蛇の列","CLOSE","報告なし"]
    
    #占有率が低い順に並び替える
    @rank=Restaurant.order_by_crowdedness
    set_crowded_consts

    #フォローの店
    @my = User.find(session[:user_id]) if session[:user_id]
  end
  
  def search
    escaped = params[:name].gsub('\\', '\\\\\\\\').gsub('%', '\%').gsub('_', '\_')
    @how_crowded = ["席ガラガラ","席が半分","埋まってる","外にも人が","長蛇の列","CLOSE","報告なし"]

    if escaped.blank?
      redirect_to :root, :alert => '店名を入力して下さい' and return
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
      #店が選択出来てない場合rootに飛ばす
      redirect_to :root and return
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
      redirect_to :report_restaurants, :alert => '店名を選択して下さい' and return
    end
    
    if params[:restaurant][:crowdedness].blank?
      redirect_to :report_restaurants, :alert => '混雑度を選択して下さい' and return
    end
    
    
    restaurant = Restaurant.find(id)
    crowd = params[:restaurant][:crowdedness]
    if crowd.blank?
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
    @my = User.find(session[:user_id]) if session[:user_id]
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
  
  def add_like_point
    user_id = session[:user_id]
    comment_id = params[:comment_id]
    comment_user_id = params[:user_id]
    
    press_user = PressedUser.new()
    press_user.comment_id = comment_id
    press_user.user_id = user_id
    press_user.save!
    
    comment_user = User.find_by(id: comment_user_id)    
    comment_user.point = comment_user.point + 2
    comment_user.save!
    
    current_user ||= User.find(session[:user_id])
    current_user.point = current_user.point + 1
    current_user.save!

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'add_like_point', locals: { restaurant: Restaurant.find(params[:restaurant_id]), commentID: comment_id, userID: comment_user_id } }
    end

    # :backがテストでNo HTTP_REFEREになるためrescueする
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def cancel_like
    user_id = session[:user_id]
    comment_id = params[:comment_id]
    comment_user_id = params[:user_id]
    
    #PressedUser.find_by(comment_id: comment_id, user_id: user_id).destroy
    @presse_and_commenter = PressedUser.find_by(comment_id: comment_id, user_id: user_id)

    if @presse_and_commenter.present?
      @presse_and_commenter.destroy
    end
    
    comment_user = User.find_by(id: comment_user_id)
    comment_user.point = comment_user.point - 2
    comment_user.save!
    
    current_user ||= User.find(session[:user_id])
    current_user.point = current_user.point - 1
    current_user.save!
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'cancel_like', locals: { restaurant: Restaurant.find(params[:restaurant_id]), commentID: comment_id, userID: comment_user_id } }
    end
    # :backがテストでNo HTTP_REFEREになるためrescueする
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def all_rest
    @restaurants = Restaurant.all.restaurant_order_hurigana
    @per_array = Array.new
    @next_index = 0

    #五十音表の配列を宣言
    @gozyuuonn = ["あ","か","さ","た","な","は","ま","や","ら","わ"]
    @gozyuuonn2 = [["あ", "い", "う", "え", "お"], ["か", "き", "く", "け", "こ"], ["さ", "し", "す", "せ", "そ"], ["た", "ち", "つ", "て", "と"], ["な", "に", "ぬ", "ね", "の"], ["は", "ひ","ふ", "へ", "ほ"], ["ま", "み", "む", "め", "も"], ["や", "ゆ", "よ"], ["ら", "り", "る", "れ", "ろ"], ["わ", "を", "ん"]]
    @how_crowded = ["席ガラガラ","席が半分","埋まってる","外にも人が","長蛇の列","CLOSE","報告なし"]
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
  end
  
  def rest_ind
    @gozyuuonn2 = [["あ", "い", "う", "え", "お"], ["か", "き", "く", "け", "こ"], ["さ", "し", "す", "せ", "そ"], ["た", "ち", "つ", "て", "と"], ["な", "に", "ぬ", "ね", "の"], ["は", "ひ","ふ", "へ", "ほ"], ["ま", "み", "む", "め", "も"], ["や", "ゆ", "よ"], ["ら", "り", "る", "れ", "ろ"], ["わ", "を", "ん"]]
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    @how_crowded = ["席ガラガラ","席が半分","埋まってる","外にも人が","長蛇の列","CLOSE","報告なし"]
    
    if params["pre_id"].blank?
      @next_index = 0
    else
      @next_index = params["pre_id"]
    end
    
    @restaurants_fast_initial = Restaurant.initial_search(@gozyuuonn2[@next_index.to_i][0])
    @restaurants_fast_initial += Restaurant.initial_search(@gozyuuonn2[@next_index.to_i][1])
    @restaurants_fast_initial += Restaurant.initial_search(@gozyuuonn2[@next_index.to_i][2])
    # ここはforでは直せそうにないです。
    unless @next_index.to_i == 7 || @next_index.to_i == 9
      @restaurants_fast_initial += Restaurant.initial_search(@gozyuuonn2[@next_index.to_i][3])
      @restaurants_fast_initial += Restaurant.initial_search(@gozyuuonn2[@next_index.to_i][4])
    end
    render :rest_ind
  end
  
  def rest_show
    @crowded_image = ["garagara","yayakomi","komi","yayamachi","machi","close2","close"]
    @how_crowded = ["席ガラガラ","席が半分","埋まってる","外にも人が","長蛇の列","CLOSE","報告なし"]

    if params["res_name"].blank?
      name = ""
    else
      name = params["res_name"]
    end
    
    @restaurants_initial = Restaurant.initial_search(name)
    render :rest_show
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
