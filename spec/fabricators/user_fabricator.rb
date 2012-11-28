Fabricator(:user) do
  name "MyName"
  email "email@email.com"
  password "awesome"
end

# this is inheriting because Robert did this.
Fabricator(:user_admin, :from => :user) do
  name "Biff"
  email "biff@example.com"
  after_create do |u|
    u.add_role :admin
  end
end

Fabricator(:user_superadmin, :from => :user) do
  name "Supera D'min"
  email "young@lovestesting.com"
  after_create do |u|
    u.add_role :super_admin
  end
end