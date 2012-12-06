# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# meeting roles
MeetingRole.create(:title => "Toastmaster", :description => "Facilitates meeting")
MeetingRole.create(:title => "Grammarian", :description => "Checks correct grammar usage")
MeetingRole.create(:title => "Timer", :description => "Measures time of speeches")
MeetingRole.create(:title => "Ah Counter", :description => "Counts filler words such as ahs and ums")
MeetingRole.create(:title => "General Evaluator", :description => "Provides general evaluation and evaluate evaluators")
MeetingRole.create(:title => "Evaluator", :description => "Evaluates speakers")
MeetingRole.create(:title => "Speaker", :description => "Gives speech")
MeetingRole.create(:title => "Table Topics Master", :description => "Facilitates impromptu speeches")
MeetingRole.create(:title => "Attendee", :description => "Attends meeting. This role cannot be deleted.")
MeetingRole.create(:title => "Absentee", :description => "Skips meeting. This role cannot be deleted.")

# manuals

manual_cc = Manual.create(:name => "Competent Communication")
Manual.create(:name => "The Entertaining Speaker")
Manual.create(:name => "Speaking to Inform")
Manual.create(:name => "Public Relations")
Manual.create(:name => "Facilitating Discussion")
Manual.create(:name => "Specialty Speeches")
Manual.create(:name => "Speeches by Management")

# projects

# projects that belong to Competent Communication manual
Project.create(:name => "Ice Breaker",           :project_number => 1,  :manual_id => manual_cc.id)
Project.create(:name => "Organize Your Speech",  :project_number => 2,  :manual_id => manual_cc.id)
Project.create(:name => "Get to the Point",      :project_number => 3,  :manual_id => manual_cc.id)
Project.create(:name => "How to Say It",         :project_number => 4,  :manual_id => manual_cc.id)
Project.create(:name => "Your Body Speaks",      :project_number => 5,  :manual_id => manual_cc.id)
Project.create(:name => "Vocal Variety",         :project_number => 6,  :manual_id => manual_cc.id)
Project.create(:name => "Research Your Topic",   :project_number => 7,  :manual_id => manual_cc.id)
Project.create(:name => "Get Comfortable with Visual Aids", :project_number => 8, :manual_id => manual_cc.id)
Project.create(:name => "Persuade with Power",   :project_number => 9,  :manual_id => manual_cc.id)
Project.create(:name => "Inspire Your Audience", :project_number => 10, :manual_id => manual_cc.id)

