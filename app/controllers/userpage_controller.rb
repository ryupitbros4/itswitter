# -*- coding:utf-8 -*-
class UserpageController < ApplicationController
  def display
    @ranking = Jam.all
    #[seki,hito,namae]
    @@subrank = [[20.0,19.0,"あがり"],[20.0,20.0,"さんちくじゅ"],[30.0,28.0,"がりゅうや"],[25.0,30.0,"とりたま"],[35.0,36.0,"通堂"]]
    @nsortrank = @@subrank
  end
  
  def display2
    @len_num = @@subrank.length - 1
    @sennyuu = []
    
    (0..@len_num).each{|num|
      @konzatu = ((@@subrank[num][1] / @@subrank[num][0])*100).to_i
      @sennyuu.push([@konzatu , 
                      @@subrank[num][2]])
    }
    @sortrank = @sennyuu.sort
  end
  
end
