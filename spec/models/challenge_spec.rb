require 'spec_helper'

describe Challenge do

  context "#mark_as_met" do
    let(:challenge) { FactoryGirl.build(:challenge) }
    before do
      challenge.stub(:amount_versus_donors_choose_fund)
      challenge.stub(:calculate_target_funding)
    end

    it "sets met to true" do
      challenge.save
      challenge.mark_as_met
      challenge.met.should be_true
    end
  end

  context "#target_funding" do
    let!(:project)   { FactoryGirl.create(:project, cost_to_complete: "40.00", total_price: "150.00") }
    let!(:challenge) { FactoryGirl.create(:challenge, project: project, amount: "25") }

    it "returns the project's current funding level plus the challenge amount" do
      challenge.target_funding.cents.should == 13500
    end
  end
end
