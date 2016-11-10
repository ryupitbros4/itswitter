# -*- coding: utf-8 -*-
class DemandsController < ApplicationController
  def index
    @demand = Demand.new
    @demands = Demand.where(archive: false).order(id: :desc)
  end

  def index_approved
    @demands = Demand.where(archive: true).order(id: :desc)
  end

  def new
    @demand = Demand.new(params.require(:demand).permit(:demand_restaurant, :free))
    if @demand.save
      redirect_to :demands_index
    else
      @demands = Demand.all.order(id: :desc)
      flash.now[:alert] = '店名を入力して下さい'
      render :action => :index
    end
  end

end
