# -*- coding:utf-8 -*-
class UserpageController < ApplicationController
  def display
    @ranking = Jam.all
    
    
    @subrank = [[2,"あがり"],[1,"さんちくじゅ"],[3,"がりゅうや"],[5,"とりたま"],[4,"通堂"]]
    @sortrank = @subrank.sort
    
    #redirect_to '/userpage/display'
  end
end
