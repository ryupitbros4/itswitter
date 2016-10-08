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
    @investigator = Restaurant.create(params.require(:restaurant).permit(:name, :num_seats, :num_people, :seats_occ))
    redirect_to :investigators_index
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
