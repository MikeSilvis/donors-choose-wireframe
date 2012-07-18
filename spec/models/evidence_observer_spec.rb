require 'spec_helper'

describe EvidenceObserver do
  context "#after_create" do
    before { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }
    let(:project) { FactoryGirl.create(:project) }
    let(:challenge) { FactoryGirl.create(:challenge, project: project) }

    it "creates an event for the evidence" do
      evidence = FactoryGirl.create(:external_evidence, challenge: challenge)
      #raise Event.last.event_type.inspect
      Event.last.event_type.should == "challenge_evidence_posted"
    end
  end
end
