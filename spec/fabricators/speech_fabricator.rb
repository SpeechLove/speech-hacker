Fabricator(:speech) do
  title         { Faker::Lorem.sentence }
  user
  project
  evaluator { Fabricate(:user) }
  meeting
end