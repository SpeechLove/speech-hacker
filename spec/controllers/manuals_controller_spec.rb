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
		it "assigns a current manual" do
			get(:show)
			assigns(:manual).should eq manual
		end
	end

end
