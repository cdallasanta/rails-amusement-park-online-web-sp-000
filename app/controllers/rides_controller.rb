class RidesController < ApplicationController
  def create
    attraction = Attraction.find(params[:ride][:attraction_id])

    if height_check(attraction) || tickets_check(attraction)
      binding.pry
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

  def height_check(attraction)
    if current_user.height < attraction.min_height
      flash[:alert] ||= []
      flash[:alert] << "You are not tall enough to ride the #{attraction.name}."
    end
  end

  def tickets_check(attraction)
    if current_user.tickets < attraction.tickets
      flash[:alert] ||= []
      flash[:alert] << "You do not have enough tickets to ride the #{attraction.name}."
    end
  end
end
