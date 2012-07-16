require 'spec_helper'

describe "Importing a project's attributes" do
  let(:project) { FactoryGirl.create(:project) }
  let(:challenge) { FactoryGirl.create(:challenge, :project_id => project.id) }

  before (:each) do
    project.challenges << challenge
    @projects = []
    @projects << project
  end

  context 'checks attributes for a project' do
    use_vcr_cassette

    it 'should update any changes to its attributes' do
      updated_project_info = ProjectImporter.perform      
      updated_project_info.first.cost_to_complete.to_i.should == 0
    end
    
    context 'when updating challenges for a project' do
      it "should update the amount of the challenge" do
        updated_challenge_info = ProjectImporter.perform
        updated_challenge_info.first.challenges.first.amount.should == -37
      end
    end
  end
end