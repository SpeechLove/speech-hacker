namespace :db do
  desc "Add junk data to database"
  task :populate => :environment do
    user = User.new( {:name => "John Admin", :email => "a@a.com", :password => "master" })
    user.add_role(:admin)
    user.save

    Meeting.create( {meeting_date: "2222-12-12", meeting_time: "17:00", description: "blah"} )
  end
end