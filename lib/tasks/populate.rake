namespace :db do
  desc "Add junk data to database"
  task :populate => :environment do
    user_superadmin = User.new( {:name => "Super Admin", :email => "super@super.com", :password => "master" })
    user_superadmin.add_role(:super_admin)
    user_superadmin.save

    user_admin = User.new( {:name => "Regular Admin", :email => "admin@admin.com", :password => "master" })
    user_admin.add_role(:admin)
    user_admin.save

    user = User.new( {:name => "Member", :email => "member@member.com", :password => "master" })
    user.save

    meeting = Meeting.create( {meeting_date: "2222-12-12", meeting_time: "17:00", description: "blah", location: "Conference room"} )

    manual_1 = Manual.new({ :name => "First Manual" })
    manual_1.save
    manual_2 = Manual.new({ :name => "Second Manual" })
    manual_2.save

    project_1 = Project.new({:manual_id => 1, :name => "Helloes", :project_number => 11 })
    project_1.save
    project_2 = Project.new({:manual_id => 1, :name => "Food", :project_number => 12 })
    project_2.save
    project_3 = Project.new({:manual_id => 2, :name => "Heroes", :project_number => 1 })
    project_3.save
    project_4 = Project.new({:manual_id => 2, :name => "Law and Order", :project_number => 2 })
    project_4.save
    project_5 = Project.new({:manual_id => 2, :name => "Community", :project_number => 3 })
    project_5.save
    project_6 = Project.new({:manual_id => 2, :name => "How to Speak French", :project_number => 4 })
    project_6.save

    speech_1 = Speech.new({:project_id => project_1.id, :meeting => meeting, :title => "I'm New In Town", :user_id => user_admin.id, :evaluator => user})
    speech_1.save
    speech_2 = Speech.new({:project_id => project_2.id, :meeting => meeting, :title => "Pancake Frisbee", :user_id => user_admin.id, :evaluator => user})
    speech_2.save
    speech_3 = Speech.new({:project_id => project_3.id, :meeting => meeting, :title => "Heroes are Overrated", :user_id => user_admin.id, :evaluator => user})
    speech_3.save
    speech_4 = Speech.new({:project_id => project_4.id, :meeting => meeting, :title => "Jury Duty Day", :user_id => user_admin.id, :evaluator => user})
    speech_4.save
    speech_5 = Speech.new({:project_id => project_5.id, :meeting => meeting, :title => "I don't know my neighbors", :user_id => user_admin.id, :evaluator => user})
    speech_5.save
    speech_6 = Speech.new({:project_id => project_6.id, :meeting => meeting, :title => "I speak great French", :user_id => user_admin.id, :evaluator => user})
    speech_6.save

    project = Project.find_by_name("Ice Breaker")
    Speech.create( {:title => "My first speech", :project_id => project_1.id, :user_id => user.id,
                    :evaluator => user_admin, :meeting => meeting })

    # Create enough data to populate a complete-looking past meeting
    # Users who will have roles where there can be only one user for that meeting with the role.
    toastmaster = User.new( {:name => "Tim Toastmaster", :email => "t@t.com", :password => "master" })
    toastmaster.save
    grammarian  = User.new( {:name => "Greg Grammarian", :email => "g@g.com", :password => "master" })
    grammarian.save
    timer       = User.new( {:name => "Timmy Timer", :email => "t2@t2.com", :password => "master" })
    timer.save
    ah_counter  = User.new( {:name => "Allen Ah Counter", :email => "a@a.com", :password => "master" })
    ah_counter.save
    general_evaluator = User.new( {:name => "Gene General Evaluator", :email => "ge@ge.com", :password => "master" })
    general_evaluator.save
    # Users who will have roles where there can be many users for that meeting with the same role.
    evaluator1 = User.create( {:name => "Junior Evaluator I", :email => "e@e.com", :password => "master" })
    evaluator2 = User.create( {:name => "Senior Evaluator II", :email => "e2@e2.com", :password => "master" })
    speaker1   = User.create( {:name => "Junior Speaker I", :email => "s@s.com", :password => "master" })
    speaker2   = User.create( {:name => "Senior Speaker II", :email => "s2@s2.com", :password => "master" })

    past_meeting = Meeting.create( { meeting_date: "2000-09-25",
                                     meeting_time: "12:00",
                                     description: "completed meeting",
                                     location: "San Francisco"
                                    } )
    # Speeches by the 2 speakers at this meeting.
    Speech.create({:project_id => project_3.id, :meeting => past_meeting, :title => "Junior Speaker's first wonderful speech",
                   :user_id => speaker1.id, :evaluator => evaluator1})
    Speech.create({:project_id => project_4.id, :meeting => past_meeting, :title => "Senior Speaker's second fantastic dictation",
                   :user_id => speaker2.id, :evaluator => evaluator2})
    # Roles for this meeting.
    toastmaster_role = MeetingRole.find_by_title("Toastmaster")
    grammarian_role  = MeetingRole.find_by_title("Grammarian")
    timer_role       = MeetingRole.find_by_title("Timer")
    ah_counter_role  = MeetingRole.find_by_title("Ah Counter")
    general_evaluator_role = MeetingRole.find_by_title("General Evaluator")
    speaker_role     = MeetingRole.find_by_title("Speaker")
    evaluator_role   = MeetingRole.find_by_title("Evaluator")

    Attendance.create({:attend => "true", :meeting_role_id => toastmaster_role.id, :user => toastmaster,
                       :meeting => past_meeting, :meeting_role => toastmaster_role})
    Attendance.create({:attend => "true", :meeting_role_id => grammarian_role.id, :user => grammarian,
                       :meeting => past_meeting, :meeting_role => grammarian_role})
    Attendance.create({:attend => "true", :meeting_role_id => timer_role.id, :user => timer,
                       :meeting => past_meeting, :meeting_role => timer_role})
    Attendance.create({:attend => "true", :meeting_role_id => general_evaluator_role.id, :user => general_evaluator,
                       :meeting => past_meeting, :meeting_role => general_evaluator_role})
    Attendance.create({:attend => "true", :meeting_role_id => ah_counter_role.id, :user => ah_counter,
                       :meeting => past_meeting, :meeting_role => ah_counter_role})
    Attendance.create({:attend => "true", :meeting_role_id => speaker_role.id, :user => speaker1,
                       :meeting => past_meeting, :meeting_role => speaker_role})
    Attendance.create({:attend => "true", :meeting_role_id => speaker_role.id, :user => speaker2,
                       :meeting => past_meeting, :meeting_role => speaker_role})
    Attendance.create({:attend => "true", :meeting_role_id => evaluator_role.id, :user => evaluator1,
                       :meeting => past_meeting, :meeting_role => evaluator_role})
    Attendance.create({:attend => "true", :meeting_role_id => evaluator_role.id, :user => evaluator2,
                       :meeting => past_meeting, :meeting_role => evaluator_role})
  end
end