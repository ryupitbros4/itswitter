# -*- coding: utf-8 -*-
require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  def setup
    @restaurant = Restaurant.new(name: "ラーメン", hurigana: "らーめん")
  end

  test "@restaurantがtrueか" do
    assert @restaurant.valid?
  end

  test "nameが存在してるか" do
    @restaurant.name = "  "
    assert_not @restaurant.valid?
  end

  test "huriganaが存在してるか" do
    @restaurant.hurigana = "  "
    assert_not @restaurant.valid?
  end

  test "nameの長さ" do
    @restaurant.name = "a" * 25
    assert_not @restaurant.valid?
  end

  test "huriganaの長さ" do
    @restaurant.hurigana = "a" * 100
    assert_not @restaurant.valid?
  end
end
