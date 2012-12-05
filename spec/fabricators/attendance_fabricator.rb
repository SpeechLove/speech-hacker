Fabricator(:attendance) do
  attend { "true" }
  meeting_role { Fabricate(:attendee) }
  meeting_role_id { 9 }
  meeting { Fabricate(:meeting) }
  user { Fabricate(:user) }
end

Fabricator(:non_attendance, :from => :attendance) do
	attend { "false" }
  meeting_role { Fabricate(:absentee) }
  meeting_role_id { 10 }
end

Fabricator(:attendance_grammarian, :from => :attendance) do
  meeting_role { Fabricate(:grammarian) }
  meeting_role_id { 2 }
end
