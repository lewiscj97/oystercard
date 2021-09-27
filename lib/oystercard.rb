class Oystercard
    attr_reader :balance

    def initialize 
        @balance = 0
    end

    def top_up(value)
        raise "Limit of £90 exceeded" if is_over_limit?(value)
        @balance += value
    end

    private

    def is_over_limit?(value)
        @balance + value > 90
    end
end
