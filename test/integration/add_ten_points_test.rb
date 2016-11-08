require 'test_helper'

class AddTenPointsTest < ActionDispatch::IntegrationTest

  fixtures :users

  def test_add_ten_points
    login
    user_points_before = User.find(session[:user_id]).point
    get "/restaurants/report"
    assert_equal '/restaurants/report', path
    assert_response :success

    post_via_redirect "/restaurants/deliver", { restaurant: { id: restaurants(:one).id, crowdedness: 0 } }
    assert_equal '/', path
    assert_response :success

    assert_equal (user_points_before + 10), User.find(session[:user_id]).point
  end
end
