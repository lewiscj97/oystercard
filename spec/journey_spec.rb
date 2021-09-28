require "journey"

describe Journey do

    let(:lea_green) {double :station}
    let(:wavertree) {double :station}

    describe "#complete" do
      it "returns false on initialisation" do
        expect(subject.complete).to eq false
      end
    end

    describe "#touch_out" do
      it "sets the journey status to complete" do
        subject.touch_in(lea_green)
        subject.touch_out(wavertree)
        expect(subject.complete).to eq true
      end

      it "records the exit station" do
        subject.touch_out(wavertree)
        expect(subject.exit_station).to eq wavertree
      end
    end

    describe "#touch_in" do
      it "will remember the starting station" do
        subject.touch_in(lea_green)
        expect(subject.entry_station).to eq lea_green
      end
    end

    describe "#penalty" do
      it "sets the fare to the penalty fare" do
        subject.penalty
        expect(subject.fare).to eq 6
      end
    end
end