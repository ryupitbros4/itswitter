# -*- coding: utf-8 -*-
require 'test_helper'

class InvestigatorsControllerTest < ActionController::TestCase

  #BASIC認証set
  setup :basic_auth_set

  test "お店を登録すると、更新情報も登録される" do
    assert_difference "Renewal.count" do
      post :create, restaurant: { name: "テスト", hurigana: "てすと",  num_seats: 3 }
    end
  end

  test "お店を登録すると、登録される更新情報がお店と関連づいている" do
    post :create, restaurant: { name: "テスト", hurigana: "てすと",  num_seats: 3 }
    latest_restaurant = Restaurant.order(id: :desc).limit(1).first
    assert_not Renewal.where(restaurant_id: latest_restaurant.id).empty?
  end

end
