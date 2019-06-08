class RidesController < ApplicationController
  def create
    attraction = Attraction.find(params[:ride][:attraction_id])
    ride = Ride.new(ride_params)
    ride.user_id = session[:user_id]
    ride.save

    flash[:alert] = ride.take_ride
    if flash[:alert] == ""
      redirect_to user_path(ride.attraction)
    else
      flash[:alert] << "Thanks for riding the #{attraction.name}!"
      redirect_to user_path(ride.user)
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:attraction_id)
  end


end
