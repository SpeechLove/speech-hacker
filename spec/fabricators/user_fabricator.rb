Fabricator(:user) do
  name "MyName"
  email { Faker::Internet.email } # the brackets are for creating a different faker each time instead of getting the same one.
  password "awesome"
end

# this is inheriting because Robert did this.
Fabricator(:user_admin, :from => :user) do
  name "Biff"
  after_create do |u|
    u.add_role :admin
  end
end

Fabricator(:user_superadmin, :from => :user) do
  name "Supera D'min"
  after_create do |u|
    u.add_role :super_admin
  end
end

Fabricator(:user_testing, :from => :user) do
  id 1
  name "Test User"
end