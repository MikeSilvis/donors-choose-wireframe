require 'spec_helper'

describe EvidenceObserver do
  context "#after_create" do
    use_vcr_cassette
    before { Challenge.any_instance.stub(:amount_versus_donors_choose_fund) }
    let(:project) { FactoryGirl.create(:project) }
    let(:challenge) { FactoryGirl.create(:challenge, project: project) }
    let!(:evidence) {FactoryGirl.create(:image_evidence, challenge: challenge) }

    it "creates an event for the evidence" do
      Event.last.event_type.should == "challenge_evidence_posted"
    end

    it "stores the display html for the evidence" do
      Event.last.display_html.should == evidence.embed
    end

    it "stores the display html for an uploaded image" do
      ImageUploader.any_instance.stub(:file).and_return(true)
      ImageUploader.any_instance.stub(:url).and_return("http://www.insidegatlinburg.com/wp-content/RainbowTrout_MendLess_2.jpg")
      img_evi = FactoryGirl.create(:upload_evidence)
      Event.last.display_html.should == img_evi.embed
    end
  end
end
