class AttractionsController < ApplicationController
  before_action :is_authenticated?, except: [:index]
  def index
    @attractions = Attraction.order(:name)
  end

  def show
    @attraction = Attraction.find(params[:id])
  end

  def take_ride
    @attraction = Attraction.find(params[:id])
    @ride = Ride.new(user: current_user, attraction: @attraction)
    messages = @ride.take_ride

    if messages.class != String
      @ride.save
      flash[:message] = "Thanks for riding the #{@attraction.name}!"
    else
      flash[:message] = messages
    end

    redirect_to user_path(current_user)
  end
end