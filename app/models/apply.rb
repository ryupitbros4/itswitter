# -*- coding: utf-8 -*-
class Apply < ActiveRecord::Base
  validates :apply_restaurant, presence: { message:"店名を入力して下さい" }
end
