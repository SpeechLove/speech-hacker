Fabricator(:attendance) do
	meeting_role {Fabricate(:meeting_role)}
	meeting_role_id {1}
  meeting { Fabricate(:meeting) }
  user { Fabricate(:user) }
end
