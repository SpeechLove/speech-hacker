require 'spec_helper'

describe "Meetings", :js => true do
  describe "view meetings" do
    let!(:meeting) { Fabricate(:meeting,
                                meeting_date: Date.today,
                                meeting_time: "18:00") }

    it "shows meeting date and time for each meeting" do
      visit meetings_path
      page.should have_link(Date.today.to_s)
      page.should have_content("18:00")
    end
  end

end