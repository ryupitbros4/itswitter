class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    @per_array = Array.new
    
    @restaurants.each do |restaurant|
      per = ((restaurant.num_people.to_f/restaurant.num_seats.to_f)*100).round
      @per_array.push([per,restaurant.name])
    end
    
    @rank = @per_array.sort
    @len_num = @rank.length - 1
  end

end
