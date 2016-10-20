class DemandsController < ApplicationController
  def index
    #@demand = Demand.new
    @demands = Demand.all.order(id: :desc)
  end

  def new
    @demand = Demand.new(params.require(:apply).permit(:demand_restaurant, :free))
    if @demand.save
      redirect_to :demands_index
    else
      @applies = Demand.all.order(id: :desc)
      render 'index'
    end
  end

end
