# -*- coding: utf-8 -*-
class Restaurant < ActiveRecord::Base
  has_many :comments
  has_many :users, :through => :comments

  validates :name, presence: { message:"店名を入力してください"}, 
  length: { maximum: 24, message:"店名は24文字以下にしてください"}

  validates :hurigana, presence: { message:"ふりがなを入力してください"},
  length: { maximum: 99, message:"ふりがなは99文字以下にしてください"}

  #ここでソートすることでheroku上でも順番に表示できる
  scope :restaurant_order_hurigana, -> {order('hurigana COLLATE "C" ASC')}

  def crowdedness
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    return c.crowdedness if c
    return 6
  end

  def self.order_by_crowdedness
    Restaurant.all.sort_by(&:crowdedness)
  end
end
