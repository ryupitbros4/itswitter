# -*- coding: utf-8 -*-
class Demand < ActiveRecord::Base
  validates :demand_restaurant, presence: { message:"店名を入力して下さい" }

  def self.approved
    Demand.where(archive: true)
  end

  def self.unapproved
    Demand.where(archive: false)
  end
end
