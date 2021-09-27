class Oystercard
    attr_reader :balance

    LIMIT = 90

    def initialize 
        @balance = 0
        @active = false
    end

    def top_up(value)
        raise "Limit of £#{LIMIT} exceeded" if is_over_limit?(value)
        @balance += value
    end

    def deduct(value)
      raise "Insufficient funds on Oystercard" if insufficient_funds?(value)
      @balance -= value
    end

    def in_journey?
      @active
    end

    def touch_in
      @active = true
    end

    def touch_out
      @active = false
    end

    private

    def is_over_limit?(value)
        @balance + value > LIMIT
    end

    def insufficient_funds?(value)
      @balance - value < 0
    end
end
