require_relative "journey"

class JourneyLog
    attr_reader :journey_class

    def initialize(journey = Journey)
        @journey_class = journey
    end

    def start(entry_station)
        journey = @journey.new
        journey.touch_in(entry_station)
    end
end
