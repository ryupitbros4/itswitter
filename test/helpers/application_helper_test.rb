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
    assert_equal "1分8秒", sec2h(68)
  end
  test "1時間の変換" do
    assert_equal "1時間", sec2h(3600)
  end
  test "1時間より長い変換" do
    assert_equal "1時間1分40秒", sec2h(3700)
  end
end
