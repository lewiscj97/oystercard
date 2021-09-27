class Oystercard
    attr_reader :balance
    attr_reader :entry_station

    UPPER_LIMIT = 90
    LOWER_LIMIT = 1

    def initialize 
        @balance = 0
        @active = false
    end

    def top_up(value)
        raise "Limit of £#{UPPER_LIMIT} exceeded" if is_over_limit?(value)
        @balance += value
    end

    def in_journey?
      @active
    end

    def touch_in(entry_station)
      raise "Must have minimum of £#{LOWER_LIMIT} on card to travel" if insufficient_funds?
      @entry_station = entry_station
      @active = true
    end

    def touch_out
      @active = false
      @entry_station = nil
      deduct
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
end
