require 'spec_helper'

describe Manual do
  let!(:manual) {Manual.create(:name => "Hello")}
  it { should have_many :projects }
  it { should validate_presence_of :name}
end
