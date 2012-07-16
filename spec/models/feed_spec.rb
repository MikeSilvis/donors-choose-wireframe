require 'spec_helper'

describe "Feed" do
  let(:project) { FactoryGirl.create(:project) }
  describe ".for(project)" do
    it "returns a feed object" do
      Feed.for(project).should be_a Feed
    end

    it "returns an object with the project as an attribute" do
      Feed.for(project).project.should == project
    end
  end

  describe "#items" do
    let(:feed) { Feed.for(project) }
    it "returns the value of #items_for_project" do
      feed.items.should == feed.items_for_project
    end
  end

  describe "#items_for_project" do
    context "the project has no messages or events" do
      it "returns an empty array" do
        Feed.for(project).items_for_project.should == []
      end
    end

    context "the project has messages and events" do
      let(:project) { FactoryGirl.create(:project_with_the_works) }
      let(:feed) { Feed.for(project) }

      it "returns an array with the length equal to total messages and events" do
        feed.items.count.should == 5
      end

      it "returns an array of messages and events sorted by descending created date" do
        items = feed.items
        items.each_with_index do |item, index|
          if items[index + 1]
            item.created_at.should >= items[index + 1].created_at
          end
        end
      end
    end
  end
end
