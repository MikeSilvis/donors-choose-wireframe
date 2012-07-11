require 'spec_helper'

describe "Creating a project" do

  context "When I visit the homepage" do
    before(:each) { visit root_path }

    it "shows a form for creating a new project" do
      page.should have_selector("#new_project")
    end

    it "creates a project from a donors choose url" do
      fill_in "project_proposal_url", with: "http://www.donorschoose.org/project/a-library-for-all-to-enjoy/793053/"
      click_link_or_button "Create Project"
      page.should have_content("Engaging Students in Learning")
    end
  end

end
