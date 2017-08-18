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

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)

    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      redirect_to new_attraction_path
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])

    if @attraction.update(attraction_params)
      redirect_to attraction_path(@attraction)
    else
      redirect_to edit_attraction_path
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :nausea_rating, :happiness_rating, :min_height, :tickets)
  end
end