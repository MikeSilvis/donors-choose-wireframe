require 'spec_helper'

describe "Creating a new challenge" do

  context "When I visit the page for a project" do
    let(:project) { FactoryGirl.create(:project) }
    before(:each) { visit project_path(project) }

    it "shows a link for creating a new project" do
      page.should have_content("Create New Challenge")
    end

    context "and when I click on the new challenge link" do
      it "should take me to a form to create a new challenge" do
        click_link("Create New Challenge")
        page.should have_content("Creating a new challenge")
      end
    end
  end


end
