require 'test_helper'

class DemandsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "承認済みの申請はリストに表示されない" do
    get :index
    assert_equal 2, assigns(:demands).length
  end

  test "承認済みの申請だけがリストに表示される" do
    get :index_approved
    assert_equal 3, assigns(:demands).length
  end
end
