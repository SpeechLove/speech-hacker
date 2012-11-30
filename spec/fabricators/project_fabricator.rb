Fabricator(:project) do
  name      { Faker::Lorem.sentence }
  project_number    1
  manual
end
