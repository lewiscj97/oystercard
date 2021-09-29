require_relative 'journey'
require_relative 'journey_log'

class Oystercard
    attr_reader :balance
    attr_reader :entry_station
    attr_reader :journey_log
    attr_reader :journey

    UPPER_LIMIT = 90
    LOWER_LIMIT = 1

    def initialize(journey = Journey, journey_log = JourneyLog.new) 
        @balance = 0
        @journey_log = journey_log
        @journey_class = journey
    end

    def top_up(value)
        raise "Limit of £#{UPPER_LIMIT} exceeded" if is_over_limit?(value)
        @balance += value
    end

    def in_journey?
      !@journey_log.current_journey.nil?
    end

    def touch_in(entry_station)
      raise "Must have minimum of £#{LOWER_LIMIT} on card to travel" if insufficient_funds?
      not_tapping_out if @journey_log.current_journey.nil?
      @journey_log.start(entry_station)
    end

    def touch_out(exit_station)
      # not_tapping_in if !@journey_log.current_journey.nil?
      end_journey(exit_station)
    end

    private

    def is_over_limit?(value)
        @balance + value > UPPER_LIMIT
    end

    def insufficient_funds?
      @balance < LOWER_LIMIT
    end

    def deduct
      @balance -= @journey_log.current_journey.fare
    end

    def end_journey(exit_station)
      deduct
      @journey_log.finish(exit_station)
    end

    def not_tapping_out
      @journey_log.current_journey.penalty
      end_journey(nil)
    end
    
    def not_tapping_in
      @journey_log.start(nil)
      @journey_log.current_journey.penalty
    end
end
