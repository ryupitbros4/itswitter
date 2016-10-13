# -*- coding: utf-8 -*-
class Restaurant < ActiveRecord::Base
  validates :name, presence: { message:"店名を入力してください"}, 
  length: { maximum: 24, message:"店名は24文字以下にしてください"}

  validates :num_seats, presence: { message:"席数を入力してください"}
  validates :num_seats, numericality: { only_integer: true, message:"席数は数値を入力してください" },
  inclusion: { in: 1..999, message:"席数は1~999で入力してください"}, allow_blank: true

  validates :hurigana, presence: { message:"ふりがなを入力してください"},
  length: { maximum: 99, message:"ふりがなは99文字以下にしてください"}
end
