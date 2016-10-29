require 'test_helper'

class RenewalsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "一覧画面で更新情報が取得できる" do
    get :index
    assert_equal 2, assigns(:renewals).length
  end

  test "詳細画面で更新情報が取得できる" do
    one = renewals(:one)
    get :show, id: one.id
    assert_equal "更新情報_1", assigns(:renewal).update_info
  end
end
