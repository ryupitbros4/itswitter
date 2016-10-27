# -*- coding: utf-8 -*-
require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def setup
    @feedback = Feedback.new(name: "匿名", opinion: "鳥玉美味しい",archive: false)
  end

  test "@feedbackがtrueか" do
    assert @feedback.valid?
  end

  test "nameがあるか" do
    @feedback.name = ""
    assert_not @feedback.valid?
  end

  test "opinionがあるか" do
    @feedback.opinion = ""
    assert_not @feedback.valid?
  end

  test "nameの長さ" do
    @feedback.name = "a" * 25
    assert_not @feedback.valid?
  end

end
