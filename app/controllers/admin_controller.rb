class AdminController < ApplicationController
  def index
    @demands = Demand.all.order(id: :desc)
  end

  def archive_demand
    demand = Demand.find(params[:id])
    unless demand
      flash[:error] = "指定した申請が見つかりませんでした。demand_id=#{params[:id]}"
      redirect_to :admin_index
      return
    end
    demand.archive = true
    demand.save!
    redirect_to :admin_index
  end
end
