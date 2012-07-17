require 'spec_helper'

describe Challenge do
  describe "#create" do
    before(:each) { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }

    context "associations" do
      let(:challenge) { FactoryGirl.create(:challenge) }

      it "has a corresponding challenge creation event" do
        challenge.challenge_creation_event.should_not be_nil
      end

      it "responds to .challenge_creation_event" do
        challenge.challenge_met_event
      end
    end

    it "creates a corresponding challenge created event after save" do
      expect{ FactoryGirl.create(:challenge) }.to change{ChallengeCreationEvent.count}.by(1)
    end
  end

  describe "#mark_as_met" do
    before(:each) { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }
    it "creates a corresponding challenge met event" do
      challenge = FactoryGirl.create(:challenge)
      expect{ challenge.mark_as_met }.to change{ChallengeMetEvent.count}.by(1)
    end
  end
end
