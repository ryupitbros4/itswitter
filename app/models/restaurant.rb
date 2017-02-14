# -*- coding: utf-8 -*-
class Restaurant < ActiveRecord::Base
  has_many :comments
  has_many :users, :through => :comments
  has_many :favorite_restaurants
  has_many :users, :through => :favorite_restaurants

  has_many :opening_hours, dependent: :destroy

  validates :name, presence: { message:"店名を入力してください"}, 
  length: { maximum: 24, message:"店名は24文字以下にしてください"}

  validates :hurigana, presence: { message:"ふりがなを入力してください"},
  length: { maximum: 99, message:"ふりがなは99文字以下にしてください"}

  #ここでソートすることでheroku上でも順番に表示できる
  scope :restaurant_order_hurigana, -> {order('hurigana COLLATE "C" ASC')}

  #トップページの表示だけを変える。commentsテーブルのcrowdednessは変えない。
  def crowdedness
    open = 0
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    r = Restaurant.where(id: self.id).order(updated_at: :desc).limit(1).first
    if r.present?
      if r.holiday.present?
        #今日が定休日の場合の処理。
        if r.holiday.include?(Time.zone.now.strftime('%w'))
          return 5
        end
      end
      #今日が営業日の場合の処理。
      #店の営業時間を取得。
      opening_hours = r.opening_hours
      #店の営業時間が登録されている場合の処理。
      if opening_hours.present?
        #初期値は営業時間外。
        #logger.debug opening_hours.inspect
        #logger.debug open.inspect
        now_time = Time.zone.now
        #logger.debug now_time.inspect
        #現在が営業時間かを判定。
        opening_hours.each do |opening_hour|
          start_time = Time.zone.local(Time.zone.now.strftime('%Y'), Time.zone.now.strftime('%m'), Time.zone.now.strftime('%d'), opening_hour.start_hour, opening_hour.start_minute)
          end_time = Time.zone.local(Time.zone.now.strftime('%Y'), Time.zone.now.strftime('%m'), Time.zone.now.strftime('%d'), opening_hour.end_hour, opening_hour.end_minute)
          #logger.debug start_time.inspect
          #logger.debug end_time.inspect
          #現在が営業時間なら、営業中に変更。
          if (now_time - start_time).to_i > 0 and (end_time - now_time).to_i > 0
            open = 1
            break
          end
        end
        #logger.debug open.inspect
        #現在が営業中の場合の処理。
        if open == 1
          return c.crowdedness if c and (Time.zone.now - c.updated_at).to_i <= 3600
          return 6
        #現在が営業時間外の場合の処理。
        else
          return 5
        end
      #店の営業時間が登録されていない場合の処理。
      else
        return c.crowdedness if c and (Time.zone.now - c.updated_at).to_i <= 3600
        return 6
      end
    end
  end
  
  def self.order_by_crowdedness
    #Restaurant.where('? - updated_at > 600', Time.zone.now.to_i ).order(updated_at: :desc).sort_by(&:crowdedness)
    #Restaurant.where((Time.zone.now - self.updated_at).to_i < 600).order(updated_at: :desc).sort_by(&:crowdedness)
    Restaurant.order(updated_at: :desc).sort_by(&:crowdedness)
  end
  
  #頭文字が一致する店名を取得する
  def self.initial_search(initial_word)
    #文字を含む店名を取得
    r = Restaurant.where('hurigana LIKE ?', "%#{initial_word}%").order(:hurigana)
    
    #濁音、半濁音に対応させるための表
    gozyuuonnd_list = ["か", "き", "く", "け", "こ","さ", "し", "す", "せ", "そ","た", "ち", "つ", "て", "と","は", "ひ","ふ", "へ", "ほ"]
    gozyuuonnd = ["が", "ぎ", "ぐ", "げ", "ご","ざ", "じ", "ず", "ぜ", "ぞ","だ", "ぢ", "づ", "で", "ど","ば", "び","ぶ", "べ", "ぼ","ぱ","ぴ","ぷ","ぺ","ぽ"]
    
    id = []
     
    #頭文字が一致する店名のidを取得
    r.each do |restaurant|
      if restaurant.hurigana.start_with?(initial_word)
        id.push(restaurant.id)
      end
    end
    
    #文字が表に含まれる場合(濁音、半濁音化できる文字)
    if gozyuuonnd_list.include?(initial_word)
      ind = gozyuuonnd_list.index(initial_word)
      r_d = Restaurant.where('hurigana LIKE ?', "%#{gozyuuonnd[ind]}%").order(:hurigana)
      
      r_d.each do |restaurant_d|
        if restaurant_d.hurigana.start_with?(gozyuuonnd[ind])
          id.push(restaurant_d.id)
        end
      end
      
      if ind >= 15
        r_p = Restaurant.where('hurigana LIKE ?', "%#{gozyuuonnd[ind + 5]}%").order(:hurigana)
        r_p.each do |restaurant_p|
          if restaurant_p.hurigana.start_with?(gozyuuonnd[ind + 5])
            id.push(restaurant_p.id)
          end
        end
      end
    end
    
    r = Restaurant.find(id)
    return r
  end
  
  def latest_comment
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    return c if c
  end

""" 
  def latest_comment_id
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    return c.id if c
  end

  #最新コメントのユーザーidを取得
  def comment_user_id
    c = Comment.where(restaurant_id: self.id).order(updated_at: :desc).limit(1).first
    return c.user_id if c
  end
"""
  
end
