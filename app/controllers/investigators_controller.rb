# -*- coding: utf-8 -*-
class InvestigatorsController < ApplicationController

  def new
    @investigator = Restaurant.new
  end

  def create
    new_rest = params.require(:restaurant).permit(:name, :hurigana, :holiday)
    @investigator = Restaurant.new(new_rest)
    begin
      Restaurant.transaction do
        @investigator.save!
        renewal = Renewal.new({ update_info: "新たな飲食店 「#{new_rest[:name]}」 が追加されました", restaurant_id: @investigator.id })
        renewal.save!
        redirect_to '/investigators/delete'
      end
    rescue => e
      logger.error e.backtrace.join("\n")
      flash.now[:alert] = "飲食店の新規登録に失敗しました。"
      render :action => :new
    end
  end

  def opening_hour_new
    @openinghour = OpeningHour.new(restaurant_id: params[:restaurant_id])
  end

  def opening_hour_create
    new_rest = params.require(:opening_hour).permit(:restaurant_id, :start_hour, :start_minute, :end_hour, :end_minute)
    @openinghour = OpeningHour.new(new_rest)
    begin
      OpeningHour.transaction do
        @openinghour.save!
        redirect_to '/investigators/delete'
      end
    rescue => e
      logger.error e.backtrace.join("\n")
      flash.now[:alert] = "営業時刻の新規登録に失敗しました。"
      render :action => :opening_hour_new
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to :investigators_delete
  end

  def delete
    @restaurants = Restaurant.order(updated_at: :desc)
    @week = ["日","月","火","水","木","金","土"]
  end

  def show
    @investigator = Restaurant.find(params[:id])
  end

  def update
    investigator = Restaurant.find(params[:id])
    begin
      Restaurant.transaction do
        investigator.update(name: params[:restaurant][:name], hurigana: params[:restaurant][:hurigana], holiday: params[:restaurant][:holiday])
        redirect_to '/investigators/delete'
      end
    rescue => e
      logger.error e.backtrace.join("\n")
      flash.now[:alert] = "飲食店の更新に失敗しました。"
      render :action => :show
    end
  end

end
