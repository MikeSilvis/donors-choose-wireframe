require 'spec_helper'

describe ChallengeEvidence do
  context("#embed") do
    use_vcr_cassette
    before { ChallengeEvidence.observers.disable :all }
    after { ChallengeEvidence.observers.enable :all }
    let(:challenge) { FactoryGirl.create(:challenge) }
    let(:image_evidence)  { FactoryGirl.create(:image_evidence) }
    let(:video_evidence)  { FactoryGirl.create(:video_evidence) }

    it "returns an html snippet for displaying the evidence" do
      image_evidence.embed.should == "<img src='http://www.makems.com/graphic/puppies-2.jpg'>"
    end

    it "returns an html snippet for displaying video evidence" do
      video_evidence.embed.should == "<iframe width=\"640\" height=\"360\" src=\"http://www.youtube.com/embed/H0Gdf285hfA?fs=1&feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
    end
  end
end
