# -*- coding: utf-8 -*-
require 'test_helper'

class RenewalTest < ActiveSupport::TestCase
  def setup
    @renewal = Renewal.new(update_info: "更新しました。")
  end

  test "renewalがtrueか" do
    assert @renewal.valid?
  end

  test "update_infoがあるか" do
    @renewal.update_info = ""
    assert_not @renewal.valid?
  end

  test "update_infoの字数制限" do
    @renewal.update_info = "a" * 51
    assert_not @renewal.valid?
  end
end
