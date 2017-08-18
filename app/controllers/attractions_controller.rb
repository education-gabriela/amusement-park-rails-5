class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.order(:name)
  end
end