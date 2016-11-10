class AdminController < ApplicationController
  def index
    @demands = Demand.all.order(id: :desc)
  end

  def archive_demand
    begin
      demand = Demand.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:warning] = "指定した申請が見つかりませんでした。demand_id=#{params[:id]}"
      redirect_to :admin_index
      return
    end
    demand.archive = true
    demand.save!
    redirect_to :admin_index
  end

  def unarchive_demand
    begin
      demand = Demand.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:warning] = "指定した申請が見つかりませんでした。demand_id=#{params[:id]}"
      redirect_to :admin_index
      return
    end
    demand.archive = false
    demand.save!
    redirect_to :admin_index
  end
end
