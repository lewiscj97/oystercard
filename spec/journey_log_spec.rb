require "journey_log"

describe JourneyLog do

    let(:journey) {double :journey, entry_station: lea_green, exit_station: wavertree, fare: 1}
    let(:lea_green) {double :station}
    let(:wavertree) {double :station}
    let(:journey_double) {double :journey, fare: 1 }
  let(:journey_class) {double :journey_class, new: journey_double}

    before(:each) do
        @subject = JourneyLog.new(journey_class)
        allow(journey_double).to receive(:touch_in)
        allow(journey_double).to receive(:touch_out)
        allow(journey_double).to receive(:entry_station) { lea_green }
        allow(journey_double).to receive(:exit_station) { wavertree }
    
    end

    describe "#start" do
        it "will start a journey with an entry station" do
            @subject.start(lea_green)
            expect(@subject.current_journey.entry_station).to eq lea_green
        end
    end

    describe "#finish" do
        it "adds an exit station to the current journey" do
            @subject.start(lea_green)
            @subject.finish(wavertree)
            expect(@subject.journeys[0].exit_station).to eq wavertree
        end
    end

    describe "#journeys" do
        it "shows all previous journeys" do
            @subject.start(lea_green)
            @subject.finish(wavertree)
            expect(@subject.journeys[0].entry_station).to eq lea_green
            expect(@subject.journeys[0].exit_station).to eq wavertree
        end
    end
end