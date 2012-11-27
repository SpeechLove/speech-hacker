require 'spec_helper'

describe "Attendances", :js => true do

  context "Future meeting" do
    let!(:meeting) { Fabricate(:meeting, :meeting_date => "12/12/2050") }

    it "shows the sign up header" do
      visit meeting_path meeting
      page.should have_content "Sign-up"
    end

    context "Attendance form" do
      it "shows the attendance confirmation selection"
    end
  end

end