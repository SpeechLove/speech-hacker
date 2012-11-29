require 'spec_helper'

describe ManualsController do
	let!(:manual) { Fabricate(:manual) }

	describe 'index' do
		it "assigns a list of manuals" do
      get(:index)
      assigns(:manuals).should eq [manual]
    end
	end

	describe 'show' do
		let(:speech) { Fabricate(:manual_one_speech) }
		let(:manual_two_speech) { Fabricate(:manual_two_speech) }

		it "assigns a current manual" do
			get(:show)
			assigns(:manual).should eq manual
		end

		it "assigns a list of the current user's speeches from the current manual" do
			get(:show)
			user.speeches.each { |speech| Manual.findspeech.project_id}
			assigns(:speeches).should eq manual.speeches
		end

		it "doesn't include speeches from other manuals in the speeches list" do
			#let(:manual_two) {Fabricate(:manual_two) }
			let(:project_from_other_manual) { Fabricate(:other_project) }


		end
	end

end
