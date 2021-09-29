require 'oystercard'
require 'station'

describe Oystercard do
  before(:each) do
    @lea_green = Station.new("Lea Green", 1)
    @wavertree = Station.new("Wavertree", 1)  
    subject.top_up(10)
  end

  context "happy path" do
    it "records a journey and deals with the balance" do
      subject.touch_in(@lea_green)
      subject.touch_out(@wavertree)

      expect(subject.journey_log.journeys[0].entry_station).to eq @lea_green
      expect(subject.journey_log.journeys[0].exit_station).to eq @wavertree
      expect(subject.journey_log.journeys[0].complete).to eq true
      expect(subject.balance).to eq 9
      expect(subject.journey).to eq nil
    end
  end

  context "doesn't touch in" do
    it "records a journey with no entry station and deducts penalty fare" do
      subject.touch_out(@wavertree)

      expect(subject.journey_log.journeys[0].entry_station).to eq nil
      expect(subject.journey_log.journeys[0].exit_station).to eq @wavertree
      expect(subject.journey_log.journeys[0].complete).to eq false
      expect(subject.balance).to eq 4
    end
  end

  context "doesn't touch out" do
    it "records a journey with no exit station and deducts penalty fare" do
      subject.touch_in(@wavertree)
      subject.touch_in(@lea_green)

      expect(subject.journey_log.journeys[0].entry_station).to eq @wavertree
      expect(subject.journey_log.journeys[0].exit_station).to eq nil
      # expect(subject.journey_log.journeys[0].complete).to eq false
      expect(subject.balance).to eq 4
      expect(subject.journey_log.current_journey.entry_station).to eq @lea_green
    end
  end
end