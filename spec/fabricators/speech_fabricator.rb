Fabricator(:speech) do
  title     { Faker::Lorem.sentence }
  user_id		{ Fabricate(:user).id }
  project_id	{ Fabricate(:project).id }
  evaluator { Fabricate(:user) }
  meeting	{ Fabricate(:meeting) }
end
