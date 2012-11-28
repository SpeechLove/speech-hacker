namespace :db do
  desc "Add junk data to database"
  task :populate => :environment do
    user = User.new( {:name => "Super Admin", :email => "super@super.com", :password => "master" })
    user.add_role(:super_admin)
    user.save

    user = User.new( {:name => "Regular Admin", :email => "admin@admin.com", :password => "master" })
    user.add_role(:admin)
    user.save

    user = User.new( {:name => "Member", :email => "member@member.com", :password => "master" })
    user.save

    Meeting.create( {meeting_date: "2222-12-12", meeting_time: "17:00", description: "blah"} )
  end
end