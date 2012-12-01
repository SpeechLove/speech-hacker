Fabricator(:attendance) do
  meeting { Fabricate(:meeting) }
  user { Fabricate(:user) }
  meeting_role_id { Fabricate(:meeting_role).id }
end
