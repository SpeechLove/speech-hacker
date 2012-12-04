require 'spec_helper'

describe Manual do
  Fabricate(:manual)
  it { should have_many :projects }
  it { should validate_presence_of :name}
end
