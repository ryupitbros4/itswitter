class UserpageController < ApplicationController
  def display
    @ranking = Jam.all
    @ranking.title = params[:tweet][:title]
    @ranking.content = params[:tweet][:content]
    @ranking.save
  end
end
