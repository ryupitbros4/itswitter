require "test_helper"

feature "ApplyPage" do
  scenario "バリデーションに失敗した直後にリロードしてもエラー画面が表示されない" do
    visit apply_page_index_path
    click_button '登録'
    visit current_path
  end
end
