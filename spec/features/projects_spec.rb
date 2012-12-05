require 'spec_helper'

describe "Projects", :js => true do
	include Warden::Test::Helpers

	context "when user is unauthorized to edit" do
		describe "#index" do
			it "displays a notice that the user is not authorized"			
		end

		describe "#edit" do
			it "displays a notice that the user is not authorized"
		end

	end

	context "when user is authorized" do
		describe "#index" do
			it "displays a list of projects"

			it "allows the user to edit the project name"

			it "allows the user to create a new project"

			it "allows the user to delete a project"

		end


	end

end