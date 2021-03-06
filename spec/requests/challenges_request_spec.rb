require 'spec_helper'
require 'support/redirection_support'

describe "Creating a new challenge" do
  let(:project) { FactoryGirl.create(:project) }

  context "When I visit the page for a project" do
    before(:each) { visit project_path(project) }

    it "shows a link for creating a new project" do
      page.should have_content("Make Your Own Challenge!")
    end

    context "and when I click on the new challenge link" do
      it "should take me to a form to create a new challenge" do
        click_link("Make Your Own Challenge!")
        page.should have_content("do swear and affirm")
      end
    end
  end

  context "When I am on the new challenge page" do
    before :each do
      sign_in(FactoryGirl.create(:user))
      visit new_project_challenge_path(project)
      find(:xpath, "//input[@id='challenge_project_id']").set project.id
    end

    it "should allow me to fill out the info for name, challenge title, and amount" do
      page.should have_field('challenge_title')
      page.should have_field('challenge_amount')
    end

    it "should allow me to create the new challenge" do
      fill_in("challenge_title", :with => "I will shave my head")
      fill_in("challenge_amount", :with => 5)
      fill_in("challenge_display_media", :with => "http://www.flushdoggy.com/wordpress/wp-content/uploads/2012/05/male-dog.jpg")
      click_button("Sign It!")
      page.should have_content("Your challenge has been created")
    end

    it "should redirect me to form if I leave an item blank" do
      fill_in("challenge_title", :with => "I will shave my head")
      fill_in("challenge_amount", :with => 5)
      click_button("Sign It!")
      current_path.should == "/projects/1/challenges"
    end

    it "should error if amount is more than the completion amount" do
      fill_in("challenge_title", :with => "I will shave my head")
      fill_in("challenge_amount", :with => 10000)
      find(:xpath, "//input[@id='challenge_project_id']").set project.id
      click_button("Sign It!")

      current_path.should == "/projects/1/challenges"
      page.should have_selector(".inline-error")
    end
  end

  # context "Viewing an existing challenge" do
  #   use_vcr_cassette
  #   let!(:challenge) { FactoryGirl.create(:challenge, project: project) }
  #   let!(:upload_evidence) { UploadStubber.build_upload_evidence(challenge) }
  #   let!(:image_evidence) { FactoryGirl.create(:image_evidence, challenge: challenge) }

  #   it "should display the evidence for the challenge" do
  #     pending
  #     visit project_challenge_path(project, challenge)
  #     page.should have_image(upload_evidence.image_url)
  #     page.should have_image(image_evidence.external_url)
  #   end
  # end
end