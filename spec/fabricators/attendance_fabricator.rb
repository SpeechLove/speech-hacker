Fabricator(:attendance) do
  attend { "true" }
  meeting_role { Fabricate(:meeting_role) }
  meeting_role_id {1}
  meeting { Fabricate(:meeting) }
  user { Fabricate(:user) }
end

Fabricator(:non_attendance, :from => :attendance) do
	attend { "false" }
  meeting_role { Fabricate(:absentee) }
end
