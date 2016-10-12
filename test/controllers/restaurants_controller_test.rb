require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  def setup
    Rails.application.load_seed
  end

  test "初期登録された店が表示されている" do
    get :index
    assert_response :success
    assert_select 'center h1', 7
    assert_select 'center h1' do |item|
      item.each_with_index do |h1, index|
        next if index < 2
        assert_match /^.*(あがり|通堂|我流屋|三竹寿|鳥玉).*$/, h1
      end
    end
  end
end
