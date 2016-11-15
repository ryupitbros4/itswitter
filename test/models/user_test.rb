# -*- coding: utf-8 -*- 
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = User.find_by(uid: 12345)
    @user2 = User.find_by(uid: 67890)
    @user3 = User.find_by(uid: 45678)
    @user4 = User.find_by(uid: 89012)
  end

  test "ユーザーランキングの順位が正しいか" do
    assert_equal 3, @user1.rank
    assert_equal 2, @user2.rank
    assert_equal 1, @user3.rank
  end
  
  test "同率ポイントユーザーの順位はタイか" do
    assert_equal @user1.rank, @user4.rank
  end
  
end
