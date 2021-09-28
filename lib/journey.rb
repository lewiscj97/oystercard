class Journey
    MINIMUM_FARE = 1
    PENALTY_FARE = 6

    def initialize()
        @entry_station 
        @exit_station
    end

    def touch_in(entry_station)
        @entry_station = entry_station
    end

    def penalty
        return PENALTY_FARE
    end
end