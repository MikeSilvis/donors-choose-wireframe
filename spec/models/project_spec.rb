require 'spec_helper'

describe Project do
  context "Creating projects from Donors Choose Data" do
    let(:response) { double }
    before do
      response.stub(:attributes).and_return({:title => "Project Title",
                                             :proposal_url => "http://www.some-project.com"})
      DonorsChooseApi::Project.stub(:find_by_id).and_return(response)
    end

    context "#create_from_donors_choose_url" do
      it "sets attributes from the api response" do
        p = Project.new
        p.create_from_donors_choose_url("some-donors-choose-url.com")
        p.title.should == response.attributes[:title]
        p.proposal_url.should == response.attributes[:proposal_url]
      end
    end

    context ".find_or_initialize_from_donors_choose_url" do
      let(:url) { "http://www.donorschoose.org/project/help-inspire-young-authors-and-illustra/816943/?utm_source=api&amp;utm_medium=feed&amp;utm_content=bodylink&amp;utm_campaign=DONORSCHOOSE" }

      it "returns a new project with the proper donors_choose_id if it doesn't already exist" do
        project = Project.find_or_initialize_from_donors_choose_url(url)
        project.should be_a(Project)
        project.donors_choose_id.should == "816943"
        project.new_record?.should == true
      end
    end
  end
end
