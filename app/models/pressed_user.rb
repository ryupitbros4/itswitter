class PressedUser < ActiveRecord::Base
  belong_to :comment
  belong_to :user
end
