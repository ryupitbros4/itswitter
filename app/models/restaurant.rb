# -*- coding: utf-8 -*-
class Restaurant < ActiveRecord::Base
  has_many :comments
  has_many :users, :through => :comments
  has_many :users, :through => :favorite_restaurants

  validates :name, presence: { message:"店名を入力してください"}, 
  length: { maximum: 24, message:"店名は24文字以下にしてください"}

  validates :hurigana, presence: { message:"ふりがなを入力してください"},
  length: { maximum: 99, message:"ふりがなは99文字以下にしてください"}

  #ここでソートすることでheroku上でも順番に表示できる
  scope :restaurant_order_hurigana, -> {order('hurigana COLLATE "C" ASC')}

  def crowdedness
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    #トップページの表示だけを変える。commentsテーブルのcrowdednessは変えない。
    return c.crowdedness if c and (Time.zone.now - c.updated_at).to_i <= 3600
    return 6
  end

  def self.order_by_crowdedness
    Restaurant.order(updated_at: :desc).limit(10).sort_by(&:crowdedness)
  end
  
  def latest_comment
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    return c.comment if c
  end

end
