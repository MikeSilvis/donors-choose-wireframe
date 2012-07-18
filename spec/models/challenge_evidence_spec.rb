require 'spec_helper'

describe ChallengeEvidence do
  context("#embed") do
    use_vcr_cassette
    before { ChallengeEvidence.observers.disable :all }
    after { ChallengeEvidence.observers.enable :all }
    let(:challenge) { FactoryGirl.create(:challenge) }
    let(:evidence)  { FactoryGirl.create(:external_evidence) }

    it "returns an html snippet for displaying the evidence" do
      EvidenceObserver.any_instance.stub(:after_create)
      evidence.embed.should == "<img src='http://www.makems.com/graphic/puppies-2.jpg'>"
    end
  end
end
