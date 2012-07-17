require 'spec_helper'

describe Challenge do
  describe "#create" do
    before(:each) { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }

    it "creates a corresponding challenge created event after save" do
      expect{ FactoryGirl.create(:challenge) }.to change{Event.count}.by(1)
    end

    it "returns an event of proper type" do
      FactoryGirl.create(:challenge)
      Event.last.event_type.should == "challenge_created"
    end
  end

  describe "#mark_as_met" do
    before(:each) { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }
    it "creates a corresponding challenge met event" do
      challenge = FactoryGirl.create(:challenge)
      challenge.met.should be_false
      expect{ challenge.mark_as_met }.to change{Event.count}.by(1)
    end

    it "returns an event of proper type" do
      challenge = FactoryGirl.create(:challenge)
      challenge.mark_as_met
      Event.last.event_type.should == "challenge_met"
    end

    it "sets met to true" do
      challenge = FactoryGirl.create(:challenge)
      challenge.mark_as_met
      challenge.met.should be_true
    end
  end
end
