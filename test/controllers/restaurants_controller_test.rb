# -*- coding: utf-8 -*-
require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase

  def setup
    Rails.application.load_seed
  end

  test "初期登録された店が表示されている" do
    get :index
    assert_response :success
    shop_names_in_view = assigns(:rank).map(&:name)
    shops = %w(あがり 通堂 我流屋 三竹寿 鳥玉)
    shops.each do |shop|
      shop_names_in_view.include?(/^.*#{shop}.*$/)
    end
  end

  test "検索で%を特別扱いしない" do
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
    post :search, name: '\\'
    assert_response :success
    assert_equal 1, assigns(:searched).length
  end
end

