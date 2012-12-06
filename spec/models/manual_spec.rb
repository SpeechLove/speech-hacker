require 'spec_helper'

describe Manual do
  subject { Fabricate(:manual) }

  it { should have_many :projects }
  it { should validate_presence_of :name}

  describe "#projects" do 
  	let!(:project1){Fabricate(:project)}
  	let!(:manual){project1.manual}
  	let!(:manuals){Manual.all}

  	it "should return a hash of the manuals projects" do
 			manual.projects.class
  	end

  end
end
