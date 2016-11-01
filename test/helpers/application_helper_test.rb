# -*- coding: utf-8 -*-
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "1分未満の変換" do
    assert_equal "1秒", sec2h(1)
  end
  test "1分の変換" do
    assert_equal "1分", sec2h(60)
  end
  test "1分より長くて1時間未満の変換" do
    assert_equal "1分", sec2h(68)
  end
  test "1時間の変換" do
    assert_equal "1時間以上", sec2h(3600)
  end
  test "1時間より長い変換" do
    assert_equal "1時間以上", sec2h(3700)
  end
  test "59分から1時間以上への遷移" do
    assert_equal "59分", sec2h(3599)
    assert_equal "1時間以上", sec2h(3600)
  end

end
