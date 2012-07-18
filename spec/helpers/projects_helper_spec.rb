require 'spec_helper'

describe ProjectsHelper do
  context "when determining how to format a message" do
    let(:video_message) { FactoryGirl.create(:video_message) }
    let(:image_message) { FactoryGirl.create(:image_message) }
    let(:link_message)  { FactoryGirl.create(:link_message) }
    before do
      video_message.stub(:video_html).and_return("<iframe width=\"640\" height=\"360\" src=\"http://www.youtube.com/embed/LiyQ8bvLzIE?fs=1&feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>")
    end
    describe '#format_message' do
      it 'properly displays a video media_type' do
        helper.format_message(video_message).should == video_message.video_html
      end

      it 'properly displays a image media_type' do
        helper.format_message(image_message).should == image_tag(image_message.url)
      end

      it 'properly displays a link media_type' do
        helper.format_message(link_message).should == link_to(link_message.url, link_message.url, target: "_blank")
      end
    end
  end
end
