require 'spec_helper'

describe ChallengeObserver do
  context "#after_create" do
    before { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }
    let(:project) { FactoryGirl.create(:project) }

    it "creates an event for the evidence" do
      challenge = FactoryGirl.create(:challenge, project: project)
      Event.last.event_type.should == "challenge_created"
    end
  end
end
