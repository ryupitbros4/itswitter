# -*- coding: utf-8 -*-
class Feedback < ActiveRecord::Base
validates :opinion, presence: {message: "ご意見を入力してください"}
end
