require "test_helper"

feature "VisitAllPage" do
  scenario "ログインしていない状態でトップからリンクを辿ってエラーが起きないことを確認する" do
    visit root_path
    visit_all_links([])
  end

  scenario "ログインした状態でトップからリンクを辿ってエラーが起きないことを確認する" do
    login(cap: true)
    visit root_path
    visit_all_links([])
  end

  scenario "ログインしていない状態で管理画面からリンクを辿ってエラーが起きないことを確認する" do
    visit admin_index_path
    visit_all_links([])
  end

  scenario "ログインした状態で管理画面からリンクを辿ってエラーが起きないことを確認する" do
    login(cap: true)
    visit admin_index_path
    visit_all_links([])
  end

  private
  def visit_all_links(visited)
    return if visited.include? current_path
    assert_nothing_raised do
      visited << current_path
      all('a').each do |a|
        if a[:href].start_with?('/')
          visit a[:href]
          visit_all_links(visited)
        end
      end
    end
  end
end
