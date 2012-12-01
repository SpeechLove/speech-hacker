Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password "awesome"
end

# this is inheriting because Robert did this.
Fabricator(:user_admin, :from => :user) do
  after_create do |u|
    u.add_role :admin
  end
end

Fabricator(:user_superadmin, :from => :user) do
  after_create do |u|
    u.add_role :super_admin
  end
end

Fabricator(:user_testing, :from => :user) do
  id 1
  name "Test User"
end