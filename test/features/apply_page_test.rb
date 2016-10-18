require "test_helper"

feature "ApplyPage" do
  scenario "バリデーションに失敗した直後にリロードしてもエラー画面が表示されない" do
    visit apply_page_index_path
    click_button '登録'
    assert page.has_content?('入力して下さい')
    visit current_path
  end
end
