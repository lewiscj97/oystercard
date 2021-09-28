require "journey_log"

describe JourneyLog do

    let(:journey) {double :journey}
    let(:journey) {double :journey, entry_station: lea_green, exit_station: wavertree, fare: 1}
    let(:lea_green) {double :station}
    let(:wavertree) {double :station}

    describe "#initialize" do
        it "will be inialized with a journey" do
            expect(subject.journey_class).to eq Journey
        end
    end

    describe "#start" do
        it "will start a journey with an entry station" do
            subject.start(lea_green)
            expect(subject.journey_class.entry_station).to eq lea_green
        end
    end
end