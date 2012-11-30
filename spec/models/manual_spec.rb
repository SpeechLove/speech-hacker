require 'spec_helper'

describe Manual do
  Fabricate(:manual)
  it { should have_many :projects }
  it { should validate_presence_of :name}

  describe "completed_projects" do
  	it "should return a list of completed projects" do

  	end
  end


end
