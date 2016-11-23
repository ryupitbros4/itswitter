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

  test "commentの中に更新時間が一時間以内のものがあるときは、crowdednessはそれらのうち最新のものと等しい" do
    t = Time.utc(2016, 10, 12, 1, 0, 0)
    Timecop.freeze(t) do
      r = restaurants(:one)
      assert_equal 3, r.crowdedness
    end
  end

  test "commentの更新時間が全て一時間以上前のものであった場合、crowdednessは6である" do
    t = Time.utc(2016, 10, 12, 1, 1, 1)
    Timecop.freeze(t) do
      r = restaurants(:one)
      assert_equal 6, r.crowdedness
    end
  end

  test "commentが一件もないときは、crowdednessは6である" do
    r = restaurants(:two)
    assert_equal 6, r.crowdedness
  end

  test "crowdednessでソートされている" do
    t = Time.utc(2016, 10, 12, 0, 5, 0)
    Timecop.freeze(t) do
      rs = Restaurant.order_by_crowdedness
      assert_equal 'te%st_', rs.first.name
    end
  end

  test "営業時間外の店のcrowdednessは5である" do
    t = Time.zone.local(2016, 10, 12, 20, 1, 0)
    Timecop.freeze(t) do
    r = restaurants(:one)
    assert_equal 5, r.crowdedness
    end
  end

  test "定休日の店のcrowdednessは5である" do
    t = Time.zone.local(2016, 10, 12, 15, 0, 0)
    Timecop.freeze(t) do
    r = restaurants(:four)
    assert_equal 5, r.crowdedness
    end
  end
end
