# -*- coding: utf-8 -*-
require 'test_helper'

class CreateRenewalInfoTest < ActionDispatch::IntegrationTest
  fixtures :renewals

  def test_create_renewal_info
    renewal_count_before = Renewal.count

    get "/renewals"
    assert_response :success
    assert_select "div.row", :count => (renewal_count_before + 1)
    
    get "/renewals/new"
    assert_response :success
    assert_select "form input[name='renewal[update_info]']"

    post_via_redirect "/renewals", :renewal => { :update_info => "new info" }
    assert_response :success
    assert_template "renewals/new"

    assert_equal (renewal_count_before + 1), Renewal.count

    get "/renewals"
    assert_response :success
    assert_select "div.row", :count => Renewal.count + 1
  end
end
