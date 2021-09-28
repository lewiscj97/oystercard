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
    end
end