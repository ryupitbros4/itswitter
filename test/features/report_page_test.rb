# -*- coding: utf-8 -*-
require "test_helper"

feature "ReportPage" do
  scenario "店名を選択せずに伝えるを押した場合、エラー画面が表示されない" do
    login({ cap: true })
    visit report_restaurants_path
    find(:link_or_button, "伝える").trigger('click')
  end
end
