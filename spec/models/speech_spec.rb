require 'spec_helper'

describe Speech do
  # @speech_params = { :project_id => 1, :meeting_id => 2, :title => "My first speech",
  #                    :user_id => 3, :evaluator_id => 4 }
  # let!(:speech) { Speech.create(@speech_params) }

  let!(:speech) { Fabricate(:speech) }

  [:user, :evaluator].each do |object|
    it { should belong_to object }
  end

  [:project_id, :meeting_id, :user_id, :evaluator_id].each do |object|
    it { should validate_presence_of object }
  end

  describe "manual_id" do
  	let!(:project) { Fabricate(:project) }
  	let!(:speech) { Fabricate(:project_one_speech) }

  	it "returns the id of the manual associated with the speech's project" do
  		speech.manual_id.should eq project.manual_id
  	end

  end


end
