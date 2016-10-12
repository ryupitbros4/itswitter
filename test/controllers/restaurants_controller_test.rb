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
end
