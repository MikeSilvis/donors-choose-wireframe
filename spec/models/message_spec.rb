require 'spec_helper'

describe Message do
  it "requires a name" do
    expect {Message.create!(project_id: 1, body: "Message body")}.to raise_error
  end

  it "requires a body" do
    expect {Message.create!(project_id: 1, name: "Bill Gates")}.to raise_error
  end

  it "requires a project_id" do
    expect {Message.create!(name: "Bill Gates", body: "Message body")}.to raise_error
  end

  it "belongs to a project" do
    project = FactoryGirl.create(:project)
    message = FactoryGirl.create(:message, project_id: project.id)
    message.project.should == project
  end
end
