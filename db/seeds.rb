# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# meeting roles
MeetingRole.create(:title => "Toastmaster")
MeetingRole.create(:title => "Grammarian")
MeetingRole.create(:title => "Timer")
MeetingRole.create(:title => "Ah Counter")
MeetingRole.create(:title => "General Evaluator")
MeetingRole.create(:title => "Evaluator")
MeetingRole.create(:title => "Speaker")
MeetingRole.create(:title => "Table Topics Master")
MeetingRole.create(:title => "Attendee")
MeetingRole.create(:title => "Absentee")

# manuals
Manual.create(:name => "Competent Communication")
Manual.create(:name => "Advanced Communicator Bronze")
Manual.create(:name => "Advanced Communicator Silver")
Manual.create(:name => "Advanced Communicator Gold")
Manual.create(:name => "Competent Leader")
Manual.create(:name => "Advanced Leader Bronze")
Manual.create(:name => "Advanced Leader Silver")

# projects

# projects that belong to Competent Communication manual
Project.create(:name => "Ice Breaker",           :number => 1,  :manual_id => 1)
Project.create(:name => "Organize Your Speech",  :number => 2,  :manual_id => 1)
Project.create(:name => "Get to the Point",      :number => 3,  :manual_id => 1)
Project.create(:name => "How to Say It",         :number => 4,  :manual_id => 1)
Project.create(:name => "Your Body Speaks",      :number => 5,  :manual_id => 1)
Project.create(:name => "Vocal Variety",         :number => 6,  :manual_id => 1)
Project.create(:name => "Research Your Topic",   :number => 7,  :manual_id => 1)
Project.create(:name => "Get Comfortable with Visual Aids", :number => 8, :manual_id => 1)
Project.create(:name => "Persuade with Power",   :number => 9,  :manual_id => 1)
Project.create(:name => "Inspire Your Audience", :number => 10, :manual_id => 1)

