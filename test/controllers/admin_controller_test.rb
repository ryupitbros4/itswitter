# -*- coding: utf-8 -*-
require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  #BASIC認証set
  setup :basic_auth_set

  test 'vilid credentials レスポンスOKか' do
    get :index
    assert_equal 200, response.status
  end

  test 'レスポンスNGか' do
    request.headers['Authorization'] = ''
    get :index
    assert_equal 401, response.status
  end

  test "未承認の申請一覧が取得できている" do
    get :index
    assert_response :success
    assert assigns(:unapproved_demands).present?
    assert_equal 2, assigns(:unapproved_demands).length
  end

  test "承認済みの申請一覧が取得できている" do
    get :index
    assert_response :success
    assert assigns(:approved_demands).present?
    assert_equal 3, assigns(:approved_demands).length
  end

  test "申請を承認できる" do
    id = demands(:na_one).id
    put :archive_demand, id: id
    assert Demand.find(id).archive
  end

  test "承認済みの申請は承認できない" do
    id = demands(:a_one).id
    assert_no_difference "Demand.find(id).updated_at" do
      put :archive_demand, id: id
    end
  end

  test "存在しない申請を承認しようとしてもデータは変化しない" do
    before = Demand.all.order(:id).map(&:updated_at)
    put :archive_demand, id: 'not-exist'
    assert_response :redirect
    assert_equal before, Demand.all.order(:id).map(&:updated_at)
  end

  test "申請を承認取り消しできる" do
    id = demands(:a_one).id
    put :unarchive_demand, id: id
    assert_not Demand.find(id).archive
  end

  test "未承認の申請は承認取り消しできない" do
    id = demands(:na_one).id
    assert_no_difference "Demand.find(id).updated_at" do
      put :unarchive_demand, id: id
    end
  end
  test "存在しない申請を承認取り消ししようとしてもデータは変化しない" do
    before = Demand.all.order(:id).map(&:updated_at)
    put :unarchive_demand, id: 'not-exist'
    assert_response :redirect
    assert_equal before, Demand.all.order(:id).map(&:updated_at)
  end

end
