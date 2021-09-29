require_relative "journey"

class JourneyLog
    attr_reader :current_journey

    def initialize(journey = Journey)
        @journey_class = journey
        @current_journey
        @journeys = []
    end

    def start(entry_station)
        @current_journey = @journey_class.new
        @current_journey.touch_in(entry_station)
    end

    def finish(exit_station)
        @current_journey.touch_out(exit_station)
        fare = @current_journey.fare
        @journeys << @current_journey
        @current_journey = nil
        return fare
    end

    def journeys
        @journeys.map(&:clone)
    end
end
