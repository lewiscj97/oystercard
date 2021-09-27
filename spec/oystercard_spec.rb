require 'oystercard'

describe Oystercard do
    it "an onystercard will be initilized with a balance of zero" do
        expect(subject.balance).to eq 0
    end

    it "balance will be increased when the top_up method is invoked" do
        subject.top_up(5)
        expect(subject.balance).to eq 5
    end

    it "the balance cannot be increased past £90" do       
        expect{subject.top_up(95)}.to raise_error "Limit of £90 exceeded"
    end
end