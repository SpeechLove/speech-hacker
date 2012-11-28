Fabricator(:meeting_role) do
  title "Fabricated Meeting Role"
end

Fabricator(:toastmaster, :from => :meeting_role) do
	title "Toastmaster"
	id 1
end

Fabricator(:grammarian, :from => :meeting_role) do
	title "Grammarian"
	id 2
end

Fabricator(:absentee, :from => :meeting_role) do
	title "Absentee"
	id 10
end

Fabricator(:attendee, :from => :meeting_role) do
	title "Attendee"
	id 9
end



