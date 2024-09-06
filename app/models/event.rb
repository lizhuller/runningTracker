class Event < ApplicationRecord
    validates :hours, :minutes, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :miles, numericality: { greater_than: 0 }

    belongs_to :user

    def mile_time
        total_minutes = (hours.to_i * 60) + minutes.to_i
        return "00:00:00" if miles.zero?
        total_seconds_per_mile = (total_minutes * 60) / miles 
        hours_per_mile = total_seconds_per_mile / 3600 
        minutes_per_mile = (total_seconds_per_mile % 3600) / 60 
        seconds_per_mile = total_seconds_per_mile % 60 
        format("%02d:%02d:%02d", hours_per_mile, minutes_per_mile, seconds_per_mile)
    end

    def mile_time_in_minutes
        total_minutes = ((hours.to_i * 60) + minutes.to_i)
        return 0 if miles.zero?
        minutes_per_mile = total_minutes/miles
    end

    def total_time_in_minutes
        total_minutes = ((hours.to_i * 60) + minutes.to_i)
    end

    def self.total_miles_per_shoe(user_id)
        where(user_id: user_id).group(:shoe).sum(:miles) 
    end
end
