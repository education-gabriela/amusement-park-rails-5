class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :attraction

  def take_ride
    messages = []
    if self.user.tickets && self.user.tickets < self.attraction.tickets
      messages << "You do not have enough tickets to ride the #{self.attraction.name}."
    end

    if self.user.height && self.user.height < self.attraction.min_height
      messages << "You are not tall enough to ride the #{attraction.name}."
    end

    unless messages.empty?
      messages.insert(0, "Sorry.")
      return messages.join(" ")
    else
      update_user_attributes
    end
  end

  private
  def update_user_attributes
    self.user.tickets -= self.attraction.tickets
    self.user.happiness += self.attraction.happiness_rating
    self.user.nausea += self.attraction.nausea_rating
    self.user.save
  end
end