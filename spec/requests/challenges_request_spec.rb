require 'spec_helper'

describe "Creating a new challenge" do
  let(:project) { FactoryGirl.create(:project) }

  context "When I visit the page for a project" do
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

  context "When I am on the new challenge page" do
    before(:each) { visit new_challenge_path }

    it "should allow me to fill out the info for name, challenge, and amount" do
      page.should have_field('Name')
      page.should have_field('Challenge')
      page.should have_field('Minimum Amount')
      page.should have_field('Maximum Amount')
    end

    it "should allow me to create the new challenge" do
      fill_in("Name", :with => "Darrell Rivera")
      fill_in("Challenge", :with => "I will shave my head")
      fill_in("Minimum Amount", :with => 200)
      fill_in("Maximum Amount", :with => 800)
      find(:xpath, "//input[@id='challenge_project_id']").set project.id
      click_button("Create Challenge")
      page.should have_content("Your challenge has been created")
    end

    it "should redirect me to form if I leave items blank" do
      click_button("Create Challenge")
      page.should have_content("Creating a new challenge")
    end
  end
end
