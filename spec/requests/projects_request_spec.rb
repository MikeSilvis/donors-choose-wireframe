require 'spec_helper'

describe "Creating a project" do

  context "When I visit the homepage" do
    before(:each) { visit root_path }

    it "shows a form for creating a new project" do
      page.should have_selector("#new_project")
      save_and_open_page
    end
  end

end
