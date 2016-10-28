class DemandsController < ApplicationController
  def index
    @demand = Demand.new
    @demands = Demand.where(archive: false).order(id: :desc)
  end

  def new
    @demand = Demand.new(params.require(:demand).permit(:demand_restaurant, :free))
    if @demand.save
      redirect_to :demands_index
    else
      @demands = Demand.all.order(id: :desc)
      render 'index'
    end
  end

end
