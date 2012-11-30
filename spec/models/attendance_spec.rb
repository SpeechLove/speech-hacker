require 'spec_helper'

describe Attendance do
  subject { Fabricate(:attendance) }

  it { should validate_presence_of :meeting }
  it { should validate_presence_of :user }
  it { should validate_presence_of :meeting_role }
  it { should validate_uniqueness_of(:user_id).scoped_to(:meeting_id) }

  [:meeting, :user, :meeting_role].each do |object|
    it { should belong_to object }
  end
end
