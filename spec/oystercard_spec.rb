require 'oystercard'

describe Oystercard do
  let(:journey) {double :journey, entry_station: lea_green, exit_station: wavertree, fare: 1}
  let(:lea_green) {double :station}
  let(:wavertree) {double :station}
  let(:journey_double) {double :journey }
  let(:journey_class) {double :journey_class, new: journey_double}
  let(:journey_log) {double :journey_log, "[]": journey}

  before(:each) do 
    @subject = Oystercard.new(journey_class, journey_log)
    allow(journey_double).to receive(:touch_in)
    allow(journey_double).to receive(:touch_out)
    allow(journey_double).to receive(:entry_station) { lea_green }
    allow(journey_double).to receive(:exit_station) { wavertree }
    allow(journey_double).to receive(:fare) { 1 }
    allow(journey_double).to receive(:complete)
    allow(journey_log).to receive(:start)
    allow(journey_log).to receive(:finish)
  end

  describe "#initialize" do 
    it "an onystercard will be initilized with a balance of zero" do
      expect(@subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "balance will be increased when the top_up method is invoked" do
      @subject.top_up(5)
      expect(@subject.balance).to eq 5
    end

    it "the balance cannot be increased past £90" do       
        expect{@subject.top_up(95)}.to raise_error "Limit of £90 exceeded"
    end
  end

  describe "#touch_in" do
    it "doesn't let user touch in if balance is below £1" do
      expect { @subject.touch_in(lea_green) }.to raise_error "Must have minimum of £1 on card to travel"
    end
  end

  describe "#touch_out" do
    it "Will deduct the minimum fare when touched out" do
      allow(journey_log).to receive(:current_journey)
      @subject.top_up(5)
      @subject.touch_in(lea_green)
      allow(journey_log).to receive(:current_journey) {journey}
      allow(journey_log).to receive(:finish) {1}
      expect { @subject.touch_out(wavertree) }.to change{@subject.balance}.by(-1)
    end

    it "will add a complete journey to list of journeys" do
      allow(journey_log).to receive(:current_journey)
      @subject.top_up(5)
      @subject.touch_in(lea_green)
      allow(journey_log).to receive(:current_journey) {journey}
      allow(journey_log).to receive(:finish) {1}
      @subject.touch_out(wavertree)
      expect(@subject.journey_log[0].entry_station).to eq ( lea_green )
      expect(@subject.journey_log[0].exit_station).to eq ( wavertree )
    end
  end

  describe "#journey_list" do
    it "has no journeys by default" do
      allow(journey_log).to receive(:journeys) {[]}
      expect(@subject.journey_log.journeys).to eq []
    end
  end
end