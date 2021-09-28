class Oystercard
    attr_reader :balance
    attr_reader :entry_station
    attr_reader :journey_list

    UPPER_LIMIT = 90
    LOWER_LIMIT = 1

    def initialize 
        @balance = 0
        @journey_list = []
    end

    def top_up(value)
        raise "Limit of £#{UPPER_LIMIT} exceeded" if is_over_limit?(value)
        @balance += value
    end

    def in_journey?
      !@entry_station.nil?
    end

    def touch_in(entry_station)
      raise "Must have minimum of £#{LOWER_LIMIT} on card to travel" if insufficient_funds?
      if @journey.nil?
        @journey = Journey.new
        @journey.touch_in(entry_station)
      else
        @balance -= @journey.penalty
        @journey_list.push( {entry: @journey.entry_station, exit: "did not tap out"} )
        @journey = Journey.new
        @journey.touch_in(entry_station)
      end
    end

    def touch_out(exit_station)
      deduct
      record_journey(exit_station)
      @entry_station = nil
    end

    private

    def is_over_limit?(value)
        @balance + value > UPPER_LIMIT
    end

    def insufficient_funds?
      @balance < LOWER_LIMIT
    end

    def deduct
      @balance -= LOWER_LIMIT
    end

    def record_journey(exit_station)
      @journey_list.push( {entry: @entry_station, exit: exit_station} )
    end
end
