class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :attraction

  def take_ride
    errors = ""
    if self.user.height < self.attraction.min_height
      errors << "You are not tall enough to ride the #{attraction.name}."
    end
    if self.user.tickets < self.attraction.tickets
      errors << "You do not have enough tickets to ride the #{attraction.name}."
    end

    if errors == ""
      update_user
    end

    errors
  end

  def update_user
    self.user.tickets -= self.attraction.tickets
    self.user.nausea += self.attraction.nausea_rating
    self.user.happiness += self.attraction.happiness_rating

    user.save
  end
end
