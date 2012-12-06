require 'spec_helper'

describe AttendancesHelper do
	let(:user) { Fabricate(:user) }
	let(:f) { Object.new }
	let(:meeting) { Fabricate(:meeting) }

	describe '#user_attending_field' do
		context "when user is attending the meeting" do
			it "checks the 'attend' radio button as true" do
				helper.stub(:user_attending?).and_return(true)
				f.stub(:radio_button).and_return(true)
				helper.user_attending_field(f, meeting).should be_true
			end
		end

		context "when user is not attending the meeting" do
			it "checks the attend radio button as false" do
				helper.stub(:user_attending?).and_return(false)
				f.stub(:radio_button).and_return(false)
				helper.user_attending_field(f, meeting).should be_false
			end
		end
	end
end
