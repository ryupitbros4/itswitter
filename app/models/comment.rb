class Comment < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  has_many :pressed_users
end
