namespace :every_day_task do
  desc "明日の活動sの.the_day_before()を呼ぶ"
  task :call_activities_the_day_before do
    tommorow = Date.today + 1
    Activity.where(date: tommorow).each{|activity|
      activity.the_day_before()
    }
  end
end
