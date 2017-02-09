# -*- coding: utf-8 -*-
require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
=begin
  test "初期登録された店が表示されている" do
    Rails.application.load_seed
    get :index
    assert_response :success
    shop_names_in_view = assigns(:rank).map(&:name)
    shops = %w(あがり 通堂 我流屋 三竹寿 鳥玉)
    shops.each do |shop|
      assert shop_names_in_view.include?(shop)
    end
  end
=end
  test "検索で%を特別扱いしない" do
    Rails.application.load_seed
    post :search, name: '%'
    assert_response :success
    assert_equal 1, assigns(:searched).length
  end

  test "検索で_を特別扱いしない" do
    post :search, name: '_'
    assert_response :success
    assert_equal 2, assigns(:searched).length
  end

  test "\\で検索ができる" do
    Rails.application.load_seed
    post :search, name: '\\'
    assert_response :success
    assert_equal 1, assigns(:searched).length
  end

  test "同一の混雑度で更新すると、時刻が更新されている" do
    session[:user_id] = users(:two).id
    r = restaurants(:four)
    post :deliver, restaurant: { id: r.id, crowdedness: r.crowdedness }
    assert_response :redirect
    ra = Restaurant.find(r.id)
    assert_not_equal r.updated_at, ra.updated_at
  end

  """
  test "新着のお店が取得されている" do
    get :index, from: '2016-10-02 12:00:00'
    assert_equal 2, assigns(:new_restaurants).length
  end
  """


  test "ログインしていない場合はreportとdeliver出来ない" do
    get :report
    assert flash[:alert].match(/.*ログインして下さい.*/)
    post :deliver
    assert flash[:alert].match(/.*ログインして下さい.*/)
  end

=begin
  test "更新情報ページが表示されてる" do
    get :slide_info
    assert_response :success
  end
=end

  test "commentが追加されている" do
    t = Time.local(2016, 10, 13, 0, 0, 0)
    Timecop.freeze(t) do
      session[:user_id] = users(:two).id
      res = restaurants(:four)
      post :deliver, restaurant: { crowdedness: '1', id: res.id, latest_comment: '今日セールやってるよ' }
      assert_response :redirect
      insertUser = Comment.order(updated_at: :desc).limit(1).first
      assert_equal '今日セールやってるよ', insertUser.comment
    end
  end

  test "「いいね！」ボタンを押すとコメントしたユーザーに点数が加算される" do 
    session[:user_id] = users(:two).id # ユーザーはtwoさん
    before = users(:one).point
    # oneさんのコメントについていいね！をした
    post :add_like_point, {user_id: comments(:one).user_id, comment_id: comments(:one).id}
   
    assert_equal before + 2, User.find_by(id: comments(:one).user_id).point
  end

  test "「いいね！」ボタンを押すといいねしたユーザーに点数が加算される" do
    session[:user_id] = users(:two).id # ユーザーはtwoさん
    before = users(:two).point
    # oneさんのコメントについていいね！をした
    post :add_like_point, {user_id: comments(:one).user_id, comment_id: comments(:one).id}
 
    assert_equal before + 1, User.find(session[:user_id]).point
  end

  test "「いいね！」ボタンを押すとレコードが追加される" do 
    session[:user_id] = users(:two).id # ユーザーはtwoさん
    before = PressedUser.count
    # oneさんのコメントについていいね！をした
    post :add_like_point, {user_id: comments(:one).user_id, comment_id: comments(:one).id}

    assert_equal before + 1, PressedUser.count
  end

  test "「いいねを取り消す」ボタンを押すと、いいねした人といいねされた人の点数が減算される" do
    session[:user_id] = users(:two).id # ユーザーはtwoさん
    before_user = users(:two).point
    before_commenter = users(:one).point
    # oneさんのコメントについていいね！をした
    post :add_like_point, {user_id: comments(:one).user_id, comment_id: comments(:one).id}

    # oneさんのコメントについていいねを取り消した
    post :cancel_like, {user_id: comments(:one).user_id, comment_id: comments(:one).id}
    assert_equal before_user, User.find(session[:user_id]).point
    assert_equal before_commenter, User.find_by(id: comments(:one).user_id).point
  end
  
  test "「いいねを取り消す」ボタンを押すとレコードが削除される" do 
    session[:user_id] = users(:two).id # ユーザーはtwoさん
    before = PressedUser.count
    # oneさんのコメントについていいね！をした
    post :add_like_point, {user_id: comments(:one).user_id, comment_id: comments(:one).id}
    # oneさんのコメントについていいねを取り消した
    post :cancel_like, {user_id: comments(:one).user_id, comment_id: comments(:one).id}

    assert_equal before, PressedUser.count
  end
end
