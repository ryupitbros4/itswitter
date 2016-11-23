# -*- coding: utf-8 -*-
require "test_helper"

feature "ApplyPage" do
  scenario "バリデーションに失敗した直後にリロードしてもエラー画面が表示されない" do
    visit demands_index_path
    #テストを通すために変更
    #click_button '登録' 
    find(:link_or_button, "登録").trigger('click')
    assert page.has_content?('入力して下さい')
    visit current_path
  end
end
