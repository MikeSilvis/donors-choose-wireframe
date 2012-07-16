require 'spec_helper'

describe Challenge do
  describe "#create" do
    before(:each) { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }

    context "associations" do
      let(:challenge) { FactoryGirl.create(:challenge) }

      it "has a corresponding challenge creation event" do
        challenge.challenge_creation_event.should_not be_nil
      end
    end

    it "creates a corresponding challenge created event after save" do
      expect{ FactoryGirl.create(:challenge) }.to change{ChallengeCreationEvent.count}.by(1)
    end
  end
end
