class RidesController < ApplicationController
  def create
    attraction = Attraction.find(params[:ride][:attraction_id])

    height_check(attraction)
    tickets_check(attraction)

    if flash[:alert]
      redirect_to user_path(current_user)
    else
      ride = Ride.new(ride_params)
      ride.user_id = session[:user_id]

      if ride.save
        ride.update_user
        flash[:alert] ||= []
        flash[:alert] << "Thanks for riding the #{attraction.name}!"
        redirect_to user_path(ride.user)
      else
        redirect_to attraction_path(Attraction.find(params[:attraction_id]))
      end
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:attraction_id)
  end


end
