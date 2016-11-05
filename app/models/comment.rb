class Comment < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  has_many :pressed_users
  has_many :users, :through => :pressed_users
end
