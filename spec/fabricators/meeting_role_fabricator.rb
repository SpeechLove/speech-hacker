Fabricator(:meeting_role) do
  title { Faker::Lorem.sentence.chomp.split.first }
  description { Faker::Lorem.sentence }
end

# Fabricator(:meeting_role) do
#   title "Fabricated Meeting Role"
#   description "This is a made-up role!"
# end

Fabricator(:toastmaster, :from => :meeting_role) do
  title "Toastmaster"
  description "Toastmaster description"
  # id 1
end

Fabricator(:grammarian, :from => :meeting_role) do
  title "Grammarian"
  description "Grammarian description"
  # id 2
end

Fabricator(:absentee, :from => :meeting_role) do
  title "Absentee"
  description "Absentee description"
  # id 10
end

Fabricator(:attendee, :from => :meeting_role) do
  title "Attendee"
  description "Attendee description"
  # id 9
end



