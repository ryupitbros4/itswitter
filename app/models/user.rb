class User < ActiveRecord::Base
  has_many :comments
  has_many :restaurants, :through => :comments

  has_many :favorite_restaurants
  has_many :restaurants, :through => :favorite_restaurants

  has_many :pressed_users
  has_many :comments, :through => :pressed_users

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    nickname = auth[:info][:nickname]
    image_url = auth[:info][:image]
    
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
    end    
  end
  
  def rank
    User.where('point > ?', point).count + 1
  end
  
end
