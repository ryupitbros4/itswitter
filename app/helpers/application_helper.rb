# -*- coding: utf-8 -*-
module ApplicationHelper
  # 秒数を人間が読める形式に変換する
  def sec2h(t)
    if t < 60
      time = "#{t}秒"
    end
    if t/60 != 0
      time = "#{(t/60)}分"
    end
    if t/3600 != 0
      #time = "#{(t/3600)}時間#{(t/60 - (t/3600)*60)}分"
      #1時間以上の場合"1時間以上"と表示する
      time = "1時間以上"
    end

    time
  end

  # 日時をフォーマットする
  def format_date(date)
    date.strftime("%Y年%m月%d日 %H時%M分")
  end
end
