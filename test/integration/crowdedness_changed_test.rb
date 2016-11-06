require 'test_helper'

class CrowdednessChangedTest < ActionDispatch::IntegrationTest
  test "ログインして混雑度を更新すると、トップ画面でその混雑度で表示されている" do
    login
    get '/'
    assert_not response.body.match(/.*garagara.*/)
    post '/restaurants/deliver', { restaurant: { id: restaurants(:one).id, crowdedness: 0 } }
    get '/'
    assert response.body.match(/.*garagara.*/)
  end
end
