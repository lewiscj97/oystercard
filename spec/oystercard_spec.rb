require 'oystercard'

describe Oystercard do

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

  describe "#deduct" do
    it "deducts a specified amount from the card balance" do
      subject.top_up(10)
      subject.deduct(5)

      expect(subject.balance).to eq 5
    end

    it "doesn't let the balance get below £0" do
      expect { subject.deduct(5) }.to raise_error "Insufficient funds on Oystercard"
    end
  end

  describe "#in_journey?" do
    it "returns false on initialisation" do
      expect(subject.in_journey?).to eq false
    end
  end

  describe "#touch_in" do
    it "sets the card status to active" do
      subject.touch_in
      expect(subject.in_journey?).to eq true  
    end
  end

  describe "#touch_out" do
    it "sets the card status to inactive" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end
end