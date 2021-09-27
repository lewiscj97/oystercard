class Oystercard
    attr_reader :balance
    LIMIT = 90

    def initialize 
        @balance = 0
    end

    def top_up(value)
        raise "Limit of £#{LIMIT} exceeded" if is_over_limit?(value)
        @balance += value
    end

    def deduct(value)
      raise "Insufficient funds on Oystercard" if insufficient_funds?(value)
      @balance -= value
    end

    private

    def is_over_limit?(value)
        @balance + value > LIMIT
    end

    def insufficient_funds?(value)
      @balance - value < 0
    end
end
