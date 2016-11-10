# -*- coding: utf-8 -*-
require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase

  test "初期登録された店が表示されている" do
    Rails.application.load_seed
    get :index
    assert_response :success
    shop_names_in_view = assigns(:rank).map(&:name)
    shops = %w(あがり 通堂 我流屋 三竹寿 鳥玉)
    shops.each do |shop|
      assert shop_names_in_view.include?(shop)
    end
  end

  test "検索で%を特別扱いしない" do
    Rails.application.load_seed
    post :search, name: '%'
    assert_response :success
    assert_equal 1, assigns(:searched).length
  end

  test "検索で_を特別扱いしない" do
    post :search, name: '_'
    assert_response :success
    assert_equal 2, assigns(:searched).length
  end

  test "\\で検索ができる" do
    Rails.application.load_seed
    post :search, name: '\\'
    assert_response :success
    assert_equal 1, assigns(:searched).length
  end

  test "同一の混雑度で更新すると、時刻が更新されている" do
    session[:user_id] = users(:two).id
    r = restaurants(:four)
    post :deliver, restaurant: { id: r.id, crowdedness: r.crowdedness }
    assert_response :redirect
    ra = Restaurant.find(r.id)
    assert_not_equal r.updated_at, ra.updated_at
  end

  test "新着のお店が取得されている" do
    get :index, from: '2016-10-02 12:00:00'
    assert_equal 2, assigns(:new_restaurants).length
  end


  test "ログインしていない場合はreportとdeliver出来ない" do
    get :report
    assert flash[:warning].match(/.*ログインして下さい.*/)
    post :deliver
    assert flash[:warning].match(/.*ログインして下さい.*/)
  end

=begin
  test "更新情報ページが表示されてる" do
    get :slide_info
    assert_response :success
  end
=end
end

