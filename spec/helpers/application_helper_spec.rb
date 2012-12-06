require 'spec_helper'

describe ApplicationHelper do
  let(:user) { Fabricate(:user) }
  let(:meeting) { Fabricate(:meeting) }
  let(:manual) { Fabricate(:manual) }
  let(:project) { Fabricate(:project) }
  let(:speech) { Fabricate(:speech) }

  before(:each) do
    sign_in user
  end

  describe '#current_speech' do
    context "when there is a user speech" do
      it "returns the speech" do
        helper.stub(:current_user).and_return(user)
        user.stub(:meeting_speech).and_return(speech)
        helper.current_speech(meeting).should eq speech
      end
    end

    context "when there is no user speech" do
      it "builds a new speech" do
        helper.stub(:current_user).and_return(user)
        new_speech = helper.current_speech(meeting)
        user.speeches[0].should eq new_speech
      end
    end
  end

  describe '#current_manual' do
    context "the speech belongs to a project" do
      it "returns the manual of the current speech" do
        helper.stub(:current_speech).and_return(speech)
        speech.stub(:project).and_return(project)
        helper.current_manual(meeting).should eq project.manual
      end
    end

    context "the speech does not belong to a project" do
      it "returns the first manual" do
        helper.current_manual(meeting).should eq Manual.first
      end
    end
  end

  describe '#project_select' do
    it "returns all of the projects of the current speech's manual" do
      Project.stub(:find_all_by_manual_id).and_return(manual.projects)
      helper.project_select(meeting).should eq manual.projects
    end
  end
end