require 'ffaker'

10.times do
  Broadcasting.create(title: Faker::Lorem.sentence(5), started_day: Faker::Date.forward,
              ended_day: Faeker::Date.forward, started_time: Faker::Time.ramdom_time(:all), day_of_week: Faker::Lorem.word, tv_station: Faker::Lorem.word)

end
