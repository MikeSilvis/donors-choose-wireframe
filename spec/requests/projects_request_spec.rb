require 'spec_helper'

describe "Creating a project" do

  context "When I visit the homepage" do
    use_vcr_cassette

    before(:each) { visit root_path }

    it "shows a form for creating a new project" do
      page.should have_selector("#new_project")
    end

    it "creates a project from a donors choose url" do
      fill_in "project_proposal_url", with: "http://www.donorschoose.org/project/a-library-for-all-to-enjoy/793053/"
      click_link_or_button "Create Project"
      project = Project.find_by_donors_choose_id("793053")
      current_path.should == project_path(project)
      page.should have_content("A Library For All To Enjoy")
    end
  end

  context "When a project is created for the first time" do
    use_vcr_cassette
    before(:each) { visit root_path }

    it "shows a message that the project has been created successfully" do
      fill_in "project_proposal_url", with: "http://www.donorschoose.org/project/a-library-for-all-to-enjoy/793053/"
      click_link_or_button "Create Project"
      page.should have_content "Thanks for adopting this project! Use this dashboard to manage your efforts!"
    end
  end

  context "When a project is already in the system" do
    let(:project) { FactoryGirl.create(:project) }
    use_vcr_cassette
    before(:each) { visit root_path }

    it "shows a message that the project already exists" do
      fill_in "project_proposal_url", with: project.proposal_url
      click_link_or_button "Create Project"
      current_path.should == project_path(project)
      page.should have_content "This project already exists. You can contribute to it here!"
>>>>>>> 39f86bd793e8e6f314a6880c7889bdd126b4f3ac
    end
  end

end
