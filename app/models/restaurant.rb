# -*- coding: utf-8 -*-
class Restaurant < ActiveRecord::Base
  validates :name, presence: { message:"入力してください"}, 
  length: { maximum: 24, message:"24文字以下にしてください"}

  validates :num_seats, presence: { message:"入力してください"}, 
  numericality: { only_integer: true, message:"数値を入力してください" },
  inclusion: { in: 1..999, message:"席数は1~999で入力してください"}

  validates :hurigana, presence: { message:"入力してください"},
  length: { maximum: 99, message:"99文字以下にしてください"}
end
