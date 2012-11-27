require 'spec_helper'

describe Attendance do
  subject { Fabricate(:attendance) }

  it { should validate_presence_of :meeting_id }
  it { should validate_presence_of :user_id }

  %w(:meeting, :user, :meeting_role).each do |object|
    it { should belong_to object }
  end

end
