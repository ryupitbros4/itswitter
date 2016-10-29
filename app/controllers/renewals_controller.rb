# -*- coding: utf-8 -*-
class RenewalsController < ApplicationController

  def index
    @renewals = Renewal.all
  end

  def new
    @renewals = Renewal.all
    @renewal = Renewal.new
  end

  def show
    @renewal = Renewal.find(params[:id])
  end

  def create
    @renewal = Renewal.new(renewal_params)
    if @renewal.save
      redirect_to :new_renewal, notice: '更新しました'
    else
      render 'new', alert: '更新できませんでした。'
    end
  end

  def destroy
    @renewal = Renewal.find(params[:id])
    @renewal.destroy
    redirect_to new_renewal_path
  end

  private
  def renewal_params
    params[:renewal].permit(:update_info)
  end
end
