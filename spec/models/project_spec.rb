require 'spec_helper'

describe Project do
	include Warden::Test::Helpers

	let!(:project) { Fabricate(:project) }
	after(:all) { Warden.test_reset! }

  describe "validations" do
	  [:manual_id, :name, :project_number].each do |i|
	  	it { should validate_presence_of i }
	  end

	  it "doesn't allow duplicate projects with the same name"
	end

	describe "relationships" do
	  it { should belong_to :manual }
	  it { should have_many :speeches }
	end

	describe "#sorted_by_manual" do
		pending
	end

end
