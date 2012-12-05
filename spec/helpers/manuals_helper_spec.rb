require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ManualsHelper. For example:
#
# describe ManualsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ManualsHelper do
  describe "#project_completed_date" do
    it "returns the short formatted date if the speech has an associated meeting" do
      speech = Fabricate(:speech)
      project_completed_date(speech).should eq speech.meeting.formatted_short_date
    end

    it "returns 'Unknown meeting' if the speech does not have an associated meeting" do
      speech = Speech.new
      project_completed_date(speech).should eq "Unknown meeting"
    end
  end
end
