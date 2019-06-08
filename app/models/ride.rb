class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :attraction

  def take_ride
    
  end

  def update_user
    self.user.tickets -= self.attraction.tickets
    self.user.nausea += self.attraction.nausea_rating
    self.user.happiness += self.attraction.happiness_rating

    user.save
  end
end
