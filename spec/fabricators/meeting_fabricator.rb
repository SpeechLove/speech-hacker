Fabricator(:meeting) do
  meeting_date { Date.today - rand(500) }
  meeting_time { (Time.now - rand(500)).strftime('%H:%M') }
end
