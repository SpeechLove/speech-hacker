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

    manual_1 = Manual.new({ :name => "First Manual" })
    manual_1.save
    manual_2 = Manual.new({ :name => "Second Manual" })
    manual_2.save

    project_1 = Project.new({:manual_id => 1, :name => "Helloes", :project_number => 1 })
    project_1.save
    project_2 = Project.new({:manual_id => 1, :name => "Food", :project_number => 2 })
    project_2.save
    project_3 = Project.new({:manual_id => 2, :name => "Heroes", :project_number => 3 })
    project_3.save
    project_4 = Project.new({:manual_id => 2, :name => "Law and Order", :project_number => 4 })
    project_4.save
    project_5 = Project.new({:manual_id => 2, :name => "Community", :project_number => 5 })
    project_5.save

    speech_1 = Speech.new({:project_id => 1, :meeting_id => 1, :title => "I'm New In Town", :user_id => 2, :evaluator_id => 1 })
    speech_1.save
    speech_2 = Speech.new({:project_id => 2, :meeting_id => 1, :title => "Pancake Frisbee", :user_id => 2, :evaluator_id => 1 })
    speech_2.save
    speech_3 = Speech.new({:project_id => 3, :meeting_id => 1, :title => "Heroes are Overrated", :user_id => 3, :evaluator_id => 1 })
    speech_3.save
    speech_4 = Speech.new({:project_id => 4, :meeting_id => 1, :title => "Jury Duty Day", :user_id => 2, :evaluator_id => 1 })
    speech_4.save
    speech_5 = Speech.new({:project_id => 5, :meeting_id => 1, :title => "I Don't Know My Neighbors", :user_id => 2, :evaluator_id => 1 })
    speech_5.save
    speech_6 = Speech.new({:project_id => 1, :meeting_id => 1, :title => "Je m'appelle Cruella De Ville", :user_id => 3, :evaluator_id => 1})
    speech_6.save

    meeting = Meeting.create( {meeting_date: "2222-12-12", meeting_time: "17:00", description: "blah"} )

    project = Project.find_by_name("Ice Breaker")
    Speech.create( {:title => "My first speech", :project_id => project.id, :user_id => user.id,
                    :evaluator_id => user_admin.id, :meeting_id => meeting.id })
  end
end