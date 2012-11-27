require 'spec_helper'

describe Meeting do
  subject { Fabricate(:meeting) }

  it { should validate_presence_of :meeting_date }
  it { should validate_presence_of :meeting_time }
  it { should validate_format_of(:meeting_time).not_with(/\d{2}\:\d{2}/).with_message("format should be HH:MM") }
  it { should have_many :attendances }
  it { should ensure_length_of(:description).is_at_most(255) }
end