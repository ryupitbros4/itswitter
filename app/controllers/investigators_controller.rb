class InvestigatorsController < ApplicationController

  def index
    @jams = Jam.all
  end

  def update
    jam = Jam.find(params[:id])
    jam.congestion = params[:congestion]
    jam.save
    redirect_to :controller => "userpage", :action => "display"
  end

end
