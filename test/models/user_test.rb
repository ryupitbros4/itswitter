# -*- coding: utf-8 -*- 
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = User.new({provider: 'twitter', uid: '1234567890', nickname: '1たろう', image_url: '', point: '111'})
    @user1.save
    @user2 = User.new({provider: 'twitter', uid: '2345678901', nickname: '2たろう', image_url: '', point: '222'})
    @user2.save
    @user3 = User.new({provider: 'twitter', uid: '3456789012', nickname: '3たろう', image_url: '', point: '333'})
    @user3.save
    
    @user_tai1 =  User.new({provider: 'twitter', uid: '12345678901', nickname: 'タイたろう', image_url: '', point: '1'})
    @user_tai1.save
    @user_tai2 =  User.new({provider: 'twitter', uid: '12345678902', nickname: 'タイたろう2', image_url: '', point: '1'})
    @user_tai2.save
  end

  test "ユーザーランキングの順位が正しいか" do
    assert_equal 3, @user1.rank
    assert_equal 2, @user2.rank
    assert_equal 1, @user3.rank
  end
  
  test "同率ポイントユーザーの順位はタイか" do
    assert_equal @user_tai1.rank, @user_tai2.rank
  end
  
end
