# -*- coding: utf-8 -*-
class Renewal < ActiveRecord::Base
  validates :update_info, presence: {message: "更新情報を記入してください"},
  length: {maximum: 50, message: "50字以下にしてください"}
end
