require 'spec_helper'

describe "Viewing a project feed" do
  context "When I visit a project page" do
    let(:project) { FactoryGirl.create(:project) }
    context "a project has associated messages" do
      let!(:message_1) { FactoryGirl.create(:message, project_id: project.id) }
      let!(:message_2) { FactoryGirl.create(:message, project_id: project.id) }
      let!(:other_message) { FactoryGirl.create(:message, project_id: 99) }
      before(:each) { visit project_path(project) }

      it "shows each message for the project" do
        page.should have_css(".message", text: message_1.body)
        page.should have_css(".message", text: message_2.body)
      end

      it "does not show messages for other projects" do
        page.should_not have_content other_message.body
      end
    end

    context "a project does not have associated messages" do
      it "does not show any messages" do
        page.should_not have_selector ".message"
      end
    end
  end
end

describe "Creating a new feed message" do
  let(:project) { FactoryGirl.create(:project) }
  before(:each) { visit project_path(project) }

  context "with valid parameters" do
    before(:each) do
      fill_in "message_name", with: "Bill Gates"
      fill_in "message_body", with: "Hello"
      click_button :create_message
    end
    it "shows the message in the feed" do
      page.should have_css(".message", text: "Hello")
    end
  end

  context "with invalid parameters" do
    it "redisplays the form with errors" do
      pending
    end
  end
end
