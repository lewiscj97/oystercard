require "station"

describe Station do
    before(:each) do
        @subject = Station.new("Lea Green", 1)
    end
    describe "#initialize" do
        it "A station will be initialized with a name" do
            expect(@subject.name).to eq "Lea Green"
        end

        it "A station will be initialized with a zone" do
            expect(@subject.zone).to eq 1
        end
    end
end