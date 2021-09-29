class Journey
    MINIMUM_FARE = 1
    PENALTY_FARE = 6

    attr_reader :entry_station, :exit_station
    attr_accessor :complete

    def initialize()
        @entry_station = nil
        @exit_station
        @complete = false
        @fare = MINIMUM_FARE
    end

    def touch_in(entry_station)
        @entry_station = entry_station
    end

    def touch_out(exit_station)
        @exit_station = exit_station
        @complete = true if !@entry_station.nil? && !@exit_station.nil?
    end

    def fare
        penalty_fare? ? (@fare = PENALTY_FARE) : (@fare += (@entry_station.zone - @exit_station.zone).abs)
        return @fare
    end

    private

    def penalty_fare?
        @entry_station.nil? || @exit_station.nil?
    end
end