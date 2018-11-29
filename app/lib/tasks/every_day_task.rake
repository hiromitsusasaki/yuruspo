

namespace :every_day_task do
  desc "明日の活動sの.the_day_before()を呼ぶ"
  task call_activities_the_day_before: :environment do
    tommorow = Time.zone.today + 1
    Activity.where(date: tommorow).each{|activity|
      activity.the_day_before()
    }
  end
  desc "今日の活動sの.after_activity()を呼ぶ"
  task after_activity: :environment do
    today = Time.zone.today
    Activity.where(date: today).each{|activity|
      activity.after_activity()
    }
  end
end
