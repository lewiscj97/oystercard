require_relative 'journey'

class Oystercard
    attr_reader :balance
    attr_reader :entry_station
    attr_reader :journey_list
    attr_reader :journey

    UPPER_LIMIT = 90
    LOWER_LIMIT = 1

    def initialize(journey = Journey) 
        @balance = 0
        @journey_list = []
        @journey_class = journey
    end

    def top_up(value)
        raise "Limit of £#{UPPER_LIMIT} exceeded" if is_over_limit?(value)
        @balance += value
    end

    def in_journey?
      !@journey.complete
    end

    def touch_in(entry_station)
      raise "Must have minimum of £#{LOWER_LIMIT} on card to travel" if insufficient_funds?
      not_tapping_out if !@journey.nil?
      start_journey(entry_station)
    end

    def touch_out(exit_station)
      not_tapping_in if @journey.nil?
      end_journey(exit_station)
      @journey = nil
    end

    private

    def is_over_limit?(value)
        @balance + value > UPPER_LIMIT
    end

    def insufficient_funds?
      @balance < LOWER_LIMIT
    end

    def deduct
      @balance -= @journey.fare
    end

    def record_journey(exit_station)
      @journey_list.push( {entry: @entry_station, exit: exit_station} )
    end

    def start_journey(entry_station)
      @journey = @journey_class.new
      @journey.touch_in(entry_station)
    end

    def end_journey(exit_station)
      @journey.touch_out(exit_station)
      @journey_list.push( @journey )
      deduct
    end

    def not_tapping_out
      @journey.penalty
      @journey_list.push( @journey )
      deduct
    end
    
    def not_tapping_in
      @journey = @journey_class.new
      @journey.penalty
    end
end
