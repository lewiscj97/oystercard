require 'oystercard'

describe Oystercard do

  let(:lea_green) {double :station}
  let(:wavertree) {double :station}

  describe "#initialize" do 
    it "an onystercard will be initilized with a balance of zero" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "balance will be increased when the top_up method is invoked" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "the balance cannot be increased past £90" do       
        expect{subject.top_up(95)}.to raise_error "Limit of £90 exceeded"
    end
  end

  describe "#in_journey?" do
    it "returns false on initialisation" do
      expect(subject.in_journey?).to eq false
    end
  end

  describe "#touch_in" do
    it "sets the card status to active" do
      subject.top_up(5)
      subject.touch_in(lea_green)
      expect(subject.in_journey?).to eq true  
    end

    it "doesn't let user touch in if balance is below £1" do
      expect { subject.touch_in(lea_green) }.to raise_error "Must have minimum of £1 on card to travel"
    end

    it "will remember the starting station" do
      subject.top_up(5)
      subject.touch_in(lea_green)
      expect(subject.entry_station).to eq (lea_green)
    end
  end

  describe "#touch_out" do
    it "sets the card status to inactive" do
      subject.top_up(5)
      subject.touch_in(lea_green)
      subject.touch_out(wavertree)
      expect(subject.in_journey?).to eq false
    end

    it "Will deduce the minimum fare when touched out" do
      subject.top_up(5)
      subject.touch_in(lea_green)
      expect {subject.touch_out(wavertree)}.to change{subject.balance}.by(-1)
    end

    it "will add a complete journey to list of journeys" do
      subject.top_up(5)
      subject.touch_in(lea_green)
      subject.touch_out(wavertree)
      expect(subject.journey_list).to include ({entry: lea_green, exit: wavertree})
    end
  end

  describe "#journeys" do
    it "has no journeys by default" do
      expect(subject.journey_list).to eq []
    end
  end
end