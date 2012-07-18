require 'spec_helper'

describe ChallengeEvidence do
  context("#embed") do
    use_vcr_cassette
    before { EvidenceObserver.any_instance.stub(:after_create) }
    let(:challenge) { FactoryGirl.create(:challenge) }
    let(:evidence)  { FactoryGirl.create(:external_evidence) }

    it "returns an html snippet for displaying the evidence" do
      evidence.embed.should == "<img src='http://www.makems.com/graphic/puppies-2.jpg'>"
    end
  end
end
