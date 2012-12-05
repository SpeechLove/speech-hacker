Fabricator(:attendance) do
	attend {"true"}
	meeting_role {Fabricate(:toastmaster)}
	meeting_role_id {1}
  meeting { Fabricate(:meeting) }
  user { Fabricate(:user) }
end
