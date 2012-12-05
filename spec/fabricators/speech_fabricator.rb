Fabricator(:speech) do
  title     { Faker::Lorem.sentence }
  user		{ Fabricate(:user) }
  project_id	{ Fabricate(:project).id }
  evaluator { Fabricate(:user) }
  meeting_id	{ Fabricate(:meeting).id }
end