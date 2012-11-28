require 'spec_helper'

describe Manual do
  let!(:manual) {Manual.create}
  it { should have_many :projects }
end
