require 'spec_helper'

describe ApplicationHelper do
  let(:user) { Fabricate(:user) }
  let(:meeting) { Fabricate(:meeting) }

  describe '#current_project' do
    context "when there is a user speech" do

    end

    context "when there is not a user speech" do
      it "returns an empty string" do
        helper.stub(:current_user).and_return(user)
        helper.current_project(meeting).should eq ""
      end
    end
  end
end