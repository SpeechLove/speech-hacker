Fabricator(:meeting) do
  meeting_date { "2004-11-12" }
  meeting_time { "18:00" }
  location { Faker::Address.street_address(include_secondary = false)  }
end


