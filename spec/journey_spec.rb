require "journey"

describe Journey do

    let(:lea_green) { double :station, zone: 1 }
    let(:wavertree) { double :station, zone: 1 }
    let(:huyton) { double :station, zone: 2 }
    let(:roby) { double :station, zone: 3 }
    let(:ecclestone_park) { double :station, zone: 5 }

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

    describe "#fare" do
      it "returns 1 when the journey is within the same zone" do
        subject.touch_in(lea_green)
        subject.touch_out(wavertree)
        expect(subject.fare).to eq 1
      end

      it "returns 2 when the journey is made between zones 1 and 2" do
        subject.touch_in(lea_green)
        subject.touch_out(huyton)
        expect(subject.fare).to eq 2
      end

      it "returns 2 when the journey is made between zones 3 and 5" do
        subject.touch_in(roby)
        subject.touch_out(ecclestone_park)
        expect(subject.fare).to eq 3
      end
    end
end