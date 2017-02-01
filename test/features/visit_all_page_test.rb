# -*- coding: utf-8 -*-
require "test_helper"

feature "VisitAllPage" do
=begin
  scenario "ログインしていない状態でトップからリンクを辿ってエラーが起きないことを確認する" do
    visit root_path
    visit_all_links([])
  end
=end
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
    visited << current_path
    assert_nothing_raised do
      for i in (0..(all('a').length - 1)) do
        a = all('a')[i]
        if visitable(a, visited)
          visit a[:href]
          visit_all_links(visited)
        end
      end
    end
  end

  def visitable(a, visited)
    return false unless (a && a[:href] && a[:href].start_with?('http://127.0.0.1'))
    return false if a[:href].include?('#')
    path = URI.parse(a[:href]).path
    return false if path == '/logout'
    return false if path == '/auth/twitter'
    return false if visited.include?(path)
    return true
  end
end
