# -*- coding: utf-8 -*-
class Feedback < ActiveRecord::Base
  validates :name, presence: {message: "名前を入力してください"},
  length: { maximum: 24, message: "名前は24字以下にしてください"}

  validates :opinion, presence: {message: "ご意見を入力してください"}
end
