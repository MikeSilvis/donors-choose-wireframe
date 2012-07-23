require 'spec_helper'

describe Challenge do
  context "#create" do
    let(:challenge) { FactoryGirl.build(:challenge) }
    before do
      challenge.stub(:amount_versus_donors_choose_fund)
      challenge.stub(:calculate_target_funding)
    end

    it "creates a corresponding challenge created event after save" do
      expect{ challenge.save }.to change{Event.count}.by(1)
    end

    it "returns an event of proper type" do
      challenge.save
      Event.last.event_type.should == "challenge_created"
    end
  end

  context "#mark_as_met" do
    let(:challenge) { FactoryGirl.build(:challenge) }
    before do
      challenge.stub(:amount_versus_donors_choose_fund)
      challenge.stub(:calculate_target_funding)
    end

    it "creates a corresponding challenge met event" do
      challenge.save
      challenge.met.should be_false
      expect{ challenge.mark_as_met }.to change{Event.count}.by(1)
    end

    it "returns an event of proper type" do
      challenge.save
      challenge.mark_as_met
      Event.last.event_type.should == "challenge_met"
    end

    it "sets met to true" do
      challenge.save
      challenge.mark_as_met
      challenge.met.should be_true
    end
  end

  context "#cents_to_complete" do
    let(:project)   { FactoryGirl.create(:project, cost_to_complete: "50.00") }
    let(:challenge) { FactoryGirl.create(:challenge, project: project, amount: 25) }

    it "returns the remaining amount needed to satisfy the challenge" do
      challenge.cents_to_complete.should == (challenge.project.cents_to_complete - challenge.target_funding.cents)
      challenge.cents_to_complete.should == 2500
    end
  end
end
