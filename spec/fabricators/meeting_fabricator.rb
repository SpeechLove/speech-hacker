Fabricator(:meeting) do
  meeting_date { (Date.today - rand(500)).strftime("%m/%d/%Y") }
  meeting_time { (Time.now - rand(500)).strftime('%H:%M') }
end
