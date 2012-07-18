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

  context "when a message contains an external url" do
    describe '#check_for_media' do
      it 'sets the media_type and url correctly' do
        new_message = FactoryGirl.build(:video_message)
        new_message.media_type.should be_nil
        new_message.check_for_media
        new_message.media_type.should == 'video'
        new_message.url.should        == new_message.body
      end

      describe "hooks" do
        it "sets these automatically at save time" do
          new_message = FactoryGirl.build(:video_message)
          new_message.media_type.should be_nil
          new_message.save
          new_message.media_type.should == 'video'
          new_message.url.should        == new_message.body
        end
      end
    end
  end

  context "when the media type is a video" do
    use_vcr_cassette
    let(:video_message) { FactoryGirl.create(:video_message) }

    describe "#embed" do
      it 'sets the video_html correctly from embedly response' do
        video_message.embed.should == "<iframe width=\"640\" height=\"360\" src=\"http://www.youtube.com/embed/LiyQ8bvLzIE?fs=1&feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
      end
    end
  end
end
