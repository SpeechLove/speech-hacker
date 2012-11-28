require 'spec_helper'

describe Project do
  @project_params = { :manual_id => 1, :name => "Hello Project", :project_number => 1 }
  let!(:project) { Project.create(@project_params) }
  it { should belong_to :manual }
  it { should validate_presence_of :manual_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :project_number }
end
