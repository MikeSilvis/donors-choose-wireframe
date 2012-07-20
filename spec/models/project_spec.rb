require 'spec_helper'

describe Project do
  context "Creating projects from Donors Choose Data" do
    let(:response) { double }
    before do
      response.stub(:attributes).and_return({:title => "Project Title",
                                             :proposal_url => "http://www.some-project.com"})
      DonorsChooseApi::Project.stub(:find_by_id).and_return(response)
    end

    context "#set_attrs_from_donors_choose" do
      it "sets attributes from the api response" do
        p = Project.new
        p.set_attrs_from_donors_choose("some-donors-choose-url.com")
        p.title.should == response.attributes[:title]
        p.proposal_url.should == response.attributes[:proposal_url]
      end
    end

    context ".from_donors_choose_url" do
      let(:url) { "http://www.donorschoose.org/project/help-inspire-young-authors-and-illustra/816943/?utm_source=api&amp;utm_medium=feed&amp;utm_content=bodylink&amp;utm_campaign=DONORSCHOOSE" }

      it "returns a new project with the proper donors_choose_id if it doesn't already exist" do
        project = Project.from_donors_choose_url(url)
        project.should be_a(Project)
        project.donors_choose_id.should == "816943"
        project.new_record?.should == true
      end
    end

    context "#refresh_donors_choose_data" do
      before do
        response.stub(:attributes).and_return({:title => "Project Title",
                                               :cost_to_complete => "1.00"})
        DonorsChooseApi::Project.stub(:find_by_id).and_return(response)
      end
      let(:project) { FactoryGirl.create(:project) }
      it "sets its attributes to the updated data from the api" do
        project.refresh_donors_choose_data
        project.title.should == response.attributes[:title]
        project.cost_to_complete.should == response.attributes[:cost_to_complete]
      end
    end
  end
end
