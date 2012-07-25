require 'spec_helper'

describe "Creating a project" do

  context "When I visit the homepage" do
    use_vcr_cassette

    before(:each) { visit root_path }

    it "shows a form for creating a new project" do
      page.should have_selector("#new_project")
    end

    it "creates a project from a valid donors choose url" do
      fill_in "project_proposal_url", with: "http://www.donorschoose.org/project/a-library-for-all-to-enjoy/793053/"
      click_link_or_button "Adopt Project"
      project = Project.find_by_donors_choose_id("793053")
      current_path.should == new_project_challenge_path(project)
      page.should have_content("Thanks for adopting this project! To kick this party off right, create a new challenge!")
    end

    it "redirects me to home page if I put in an invalid url" do
      fill_in "project_proposal_url", with: "http://www.google.com"
      click_link_or_button "Adopt Project"
      page.should have_content("Sorry, we are unable to match the URL with a Donors Choose project")
    end
  end

  context "When a project is created for the first time" do
    use_vcr_cassette
    before { visit root_path }

    it "shows a message that the project has been created successfully" do
      fill_in "project_proposal_url", with: "http://www.donorschoose.org/project/a-library-for-all-to-enjoy/793053/"
      click_link_or_button "Adopt Project"
      current_path.should == new_project_challenge_path(Project.last)
      page.should have_content "Thanks for adopting this project! To kick this party off right, create a new challenge!"
    end
  end

  context "When a project is already in the system" do
    let(:project) { FactoryGirl.create(:project) }
    use_vcr_cassette
    before(:each) { visit root_path }

    it "shows a message that the project already exists" do
      fill_in "project_proposal_url", with: project.proposal_url
      click_link_or_button "Adopt Project"
      current_path.should == project_path(project)
      page.should have_content "This project already exists. You can contribute to it here!"
    end
  end

  context "Viewing a project" do
    let(:project) { FactoryGirl.create(:project) }

    it "displays the title as a link" do
      visit project_path(project)
      page.should have_link("Help Inspire Young Authors and Illustrators...With Books!")
    end

    it "shows the challenge posters avatar" do
      pending
      visit project_path(project)
      page.should have_image(project.owner_avatar)
    end
  end

  context "Viewing all projects" do
    let(:project) { FactoryGirl.create(:project) }

    before(:each) do
      @projects = []
      @projects << project
      visit projects_path
    end

    it "should show all projects" do
      page.should have_content("Help Inspire Young Authors and Illustrators...With Books!")
    end
  end

  # context "Viewing the challenges attached to a project" do
  #   let(:project) { FactoryGirl.create(:project) }
  #   let!(:challenge1) { FactoryGirl.create(:challenge, project: project) }
  #   let!(:challenge2) { FactoryGirl.create(:challenge, project: project) }

  #   before(:each) { visit project_path(project) }

  #   it "shows a list of challenges with relevant details" do
  #     project.challenges.each do |c|
  #       within("#feed-challenge-#{c.id}") do
  #         page.should have_content(c.name)
  #         page.should have_content(c.title)
  #         page.should have_content(c.amount)
  #       end
  #     end
  #   end
  # end
end
