require 'spec_helper'

describe User do
  describe ".find_or_create_from_auth(auth)" do
    context "there is already a user in the system with that auth" do
      let(:user) { double }
      let(:auth) { double(provider: double, uid: double) }
      it "returns that user" do
        User.stub(:find_by_provider_and_uid).and_return(user)
        User.find_or_create_from_auth(auth).should == user
      end
    end

    context "there is not a user in the system with that auth" do
      let(:auth) { double(provider: "twitter", uid: double) }
      it "calls the appropriate create_from method for the provider with the auth param" do
        User.stub(:find_by_provider_and_uid).and_return(nil)
        User.should_receive(:create_from_twitter).once.with(auth)
        User.find_or_create_from_auth(auth)
      end
    end
  end
end
