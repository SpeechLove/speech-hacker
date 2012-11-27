Fabricator(:attendance) do
  meeting { Fabricate(:meeting) }
  user { Fabricate(:user) }
  meeting_role { Fabricate(:meeting_role) }
end
