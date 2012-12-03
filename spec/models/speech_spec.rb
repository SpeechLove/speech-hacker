require 'spec_helper'

describe Speech do
  # @speech_params = { :project_id => 1, :meeting_id => 2, :title => "My first speech",
  #                    :user_id => 3, :evaluator_id => 4 }
  # let!(:speech) { Speech.create(@speech_params) }

  subject { Fabricate(:speech) }

  [:user, :evaluator, :project, :meeting].each do |object|
    it { should belong_to object }
  end
    it { should validate_presence_of :project_id}
    it { should validate_presence_of :meeting }
    it { should validate_presence_of :user_id }

  describe "#for_manual" do
  	let!(:speech) { Fabricate(:speech) }

  	it "returns the id of the manual associated with the speech's project" do
  		speech.project.manual.id.should eq(1)
  	end

  end


end
