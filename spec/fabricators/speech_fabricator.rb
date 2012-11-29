Fabricator(:speech) do
  project_id    {2}
  meeting_id    {1}
  title         {"My best speech"}
  user_id       {3}
  evaluator_id  {2}
end

Fabricator(:manual_one_speech, :from => :speech) do
	project_id 1
end

Fabricator(:manual_two_speech, :from => :speech) do
	project_id 9
end
