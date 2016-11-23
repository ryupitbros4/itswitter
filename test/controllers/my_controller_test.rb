require 'test_helper'

class MyControllerTest < ActionController::TestCase

  test "フォロー一覧の表示" do
    session[:user_id] = users(:one).id
    get :favorites
    rs = assigns(:my).restaurants
    assert_equal 2, rs.length
  end

  test "フォローするとフォロー中の数が増える" do
    assert_difference "FavoriteRestaurant.count" do
      session[:user_id] = users(:one).id
      begin
        post :follow, restaurant_id: restaurants(:three).id
      rescue ActionController::RedirectBackError
      end
    end
  end

  test "アンフォローするとフォロー中の数が減る" do
    assert_difference "FavoriteRestaurant.count", -1 do
      session[:user_id] = users(:one).id
      begin
        post :unfollow, restaurant_id: restaurants(:two).id
      rescue ActionController::RedirectBackError
      end
    end
  end

  test "フォロー中の店をフォローしてもフォロー中の数が変わらない" do
    assert_no_difference "FavoriteRestaurant.count" do
      session[:user_id] = users(:one).id
      begin
        post :follow, restaurant_id: restaurants(:two).id
      rescue ActionController::RedirectBackError
      end
    end
  end

  test "フォロー中でない店をアンフォローしてもフォロー中の数が変わらない" do
    assert_no_difference "FavoriteRestaurant.count" do
      session[:user_id] = users(:one).id
      begin
        post :unfollow, restaurant_id: restaurants(:three).id
      rescue ActionController::RedirectBackError
      end
    end
  end

end
