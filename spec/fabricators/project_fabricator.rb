Fabricator(:project) do
  name      "ProjectOne"
  project_number    1
  manual_id 1
end

Fabricator(:other_project, :from => :project) do
	name "ManualNineProject"
	project_number 2
	manual_id 9
end
