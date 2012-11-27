Fabricator(:user) do
  name "MyName"
  email "email@email.com"
  password "awesome"
end

Fabricator(:user_admin, :from => :user) do
  name "Biff"
  email "biff@example.com"
  after_create do |u|
    u.add_role :admin
  end
end