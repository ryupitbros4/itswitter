# -*- coding: utf-8 -*-
require "test_helper"

feature "VisitAllPage" do
  scenario "全てのリンクからページを辿ってエラーが起きないことを確認する" do
    visit root_path
    visited = []
    visit_all_links(visited)
  end

  private
  def visit_all_links(visited)
    return if visited.include? current_path
    visited << current_path
    all('a').each do |a|
      if a[:href].start_with?('/')
        if a[:href].include?('#')
          return current_path
        else
          visit a[:href]
          visit_all_links(visited)
        end
      end
    end
  end
end
