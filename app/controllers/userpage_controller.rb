class UserpageController < ApplicationController
  def display
    @ranking = Jam.all
  end
end
