class Event < ApplicationRecord
    validates :hours, :minutes, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :miles, numericality: { greater_than: 0 }

    belongs_to :user

    def mile_time
        total_minutes = total_time_in_minutes
        return "00:00:00" if miles.zero?
        total_seconds_per_mile = (total_minutes * 60) / miles 
        hours_per_mile = total_seconds_per_mile / 3600 
        minutes_per_mile = (total_seconds_per_mile % 3600) / 60 
        seconds_per_mile = total_seconds_per_mile % 60 
        format("%02d:%02d:%02d", hours_per_mile, minutes_per_mile, seconds_per_mile)
    end

    def mile_time_in_minutes
        total_minutes = total_time_in_minutes
        return 0 if miles.zero?
        minutes_per_mile = total_minutes/miles
    end

    def total_time_in_minutes
        total_minutes = ((hours.to_i * 60) + minutes.to_i)
    end

    def self.total_miles_per_shoe(user_id)
        where(user_id: user_id).group(:shoe).sum(:miles) 
    end

    def self.event_with_lowest_mile_time(user_id)
        where(user_id: user_id).min_by(&:mile_time_in_minutes)
    end

    def self.event_with_lowest_mile_time_this_month(user_id)
        where(user_id: user_id, date: Time.current.beginning_of_month..Time.current.end_of_month).min_by(&:mile_time_in_minutes)
    end

    def self.longest_run(user_id)
        where(user_id: user_id).max_by(&:miles)
    end

    def self.longest_run_this_month(user_id)
        where(user_id: user_id, date: Time.current.beginning_of_month..Time.current.end_of_month).max_by(&:miles)
    end

    def self.total_miles_run(user_id)
        where(user_id: user_id).sum(:miles)
    end

    def self.total_miles_run_this_month(user_id)
        where(user_id: user_id, date: Time.current.beginning_of_month..Time.current.end_of_month).sum(:miles)
    end

    def self.total_time_run(user_id)
        total_minutes = where(user_id: user_id).sum(&:total_time_in_minutes)
        total_seconds = total_minutes * 60 
        hours = total_seconds / 3600 
        minutes = (total_seconds % 3600) / 60 
        seconds = total_seconds % 60 
        format("%02d:%02d:%02d", hours, minutes, seconds)
    end

    def self.total_time_run_this_month(user_id)
        total_minutes = where(user_id: user_id, date: Time.current.beginning_of_month..Time.current.end_of_month).sum(&:total_time_in_minutes)
        total_seconds = total_minutes * 60 
        hours = total_seconds / 3600 
        minutes = (total_seconds % 3600) / 60 
        seconds = total_seconds % 60 
        format("%02d:%02d:%02d", hours, minutes, seconds)
    end

    def start_time
        date
    end
end
