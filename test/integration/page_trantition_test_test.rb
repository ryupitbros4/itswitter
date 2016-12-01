# -*- coding: utf-8 -*-
require 'test_helper'

class PageTrantitionTestTest < ActionDispatch::IntegrationTest
  test "ログインしてページを遷移したときに、ログイン情報が保持されている" do
    login
    get '/'
    assert_select 'ul[class="nav navbar-nav"] li:nth-child(4)', 'ログアウト'
    get '/demands/index'
    assert_select 'ul[class="nav navbar-nav"] li:nth-child(4)', 'ログアウト'
  end
end
