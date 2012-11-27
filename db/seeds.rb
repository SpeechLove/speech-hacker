# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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