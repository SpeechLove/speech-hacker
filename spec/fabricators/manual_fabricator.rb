Fabricator(:manual) do
  name "AwesomeManual"
  id 1
end

Fabricator(:manual_two, :from => :manual) do
	name "ManualTwo"
	id 2
end
