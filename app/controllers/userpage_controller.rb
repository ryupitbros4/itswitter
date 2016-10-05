# -*- coding:utf-8 -*-
class UserpageController < ApplicationController
  def display
        
    @subrank = [[2,"あがり"],[1,"さんちくじゅ"],[3,"がりゅうや"],[5,"とりたま"],[4,"通堂"]]
    @sortrank = @subrank

    #@sortrank = @subrank.sort
    
    #redirect_to '/userpage/display'
  end
  
  def display2
    
    @subrank = [[2,"あがり"],[1,"さんちくじゅ"],[3,"がりゅうや"],[5,"とりたま"],[4,"通堂"]]
    @sortrank = @subrank.sort
    
  end
  
end
