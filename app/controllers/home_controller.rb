class HomeController < ApplicationController
  def index
  end
  def shoe_tracker
    @total_miles_per_shoe = Event.total_miles_per_shoe(current_user)
  end
end
