class HomeController < ApplicationController
  def index
  end
  
  def shoe_tracker
    @total_miles_per_shoe = Event.total_miles_per_shoe(current_user)
  end

  def records
    @event_with_lowest_mile_time = Event.event_with_lowest_mile_time(current_user)
    @longest_run = Event.longest_run(current_user)
    @event_with_lowest_mile_time_this_month = Event.event_with_lowest_mile_time_this_month(current_user)
    @longest_run_this_month = Event.longest_run_this_month(current_user)
    @total_time_run = Event.total_time_run(current_user)
    @total_time_run_this_month = Event.total_time_run_this_month(current_user)
    @total_miles_run_this_month = Event.total_miles_run_this_month(current_user)
    @total_miles_run = Event.total_miles_run(current_user)
  end

  def calendar
    @events = Event.all 
  end
end
