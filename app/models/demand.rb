# -*- coding: utf-8 -*-
class Demand < ActiveRecord::Base
  validates :demand_restaurant, presence: { message:"店名を入力して下さい" }
end
