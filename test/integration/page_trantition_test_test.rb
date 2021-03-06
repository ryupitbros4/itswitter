# -*- coding: utf-8 -*-
require 'test_helper'

class PageTrantitionTestTest < ActionDispatch::IntegrationTest
  test "ログインしてページを遷移したときに、ログイン情報が保持されている" do
    login
    get '/'
    #assert_select 'div[class="navbar-left"] li:nth-child(3)', 'ログアウト'
    #get '/demands/index'
    #assert_select 'div[class="navbar-left"] li:nth-child(3)', 'ログアウト'
    
    assert_select 'ul[class="nav navbar-nav"] li:nth-child(1)', 'ログアウト'
    get '/demands/index'
    assert_select 'ul[class="nav navbar-nav"] li:nth-child(1)', 'ログアウト'
  end
end
