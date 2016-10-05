class HomeController < ApplicationController

  def index
    @jams = Jam.all
  end

end
