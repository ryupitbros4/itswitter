# -*- coding: utf-8 -*-
class InvestigatorsController < ApplicationController

  def index
    @restaurants = Restaurant.order('id')
  end

  def update
    restaurant = Restaurant.find(params[:id])
    restaurant.num_people = params[:congestion]
    restaurant.seats_occ = ((restaurant.num_people.to_f/restaurant.num_seats.to_f)*100).round
    restaurant.save
    redirect_to :investigators_index
  end

  def new
    @investigator = Restaurant.new
  end

  def create
    new_rest = params.require(:restaurant).permit(:name, :hurigana, :num_seats)
    @investigator = Restaurant.new(new_rest)
    if @investigator.save
      redirect_to :investigators_index
    else
      render 'new'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to :investigators_delete
  end

  def delete
    @restaurants = Restaurant.all
  end

end
