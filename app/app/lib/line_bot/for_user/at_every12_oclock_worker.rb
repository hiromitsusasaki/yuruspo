class LineBot::ForUser::AtEvery12OclockWorker
  include Sidekiq::Worker

  def perform(body)
    LineBot::ForUser::AtEvery12OclockWorker.set_for_tomorrow()
    call_activities_the_day_before()
  end


  def self.set_for_tomorrow
    tomorrow = Time.zone.tomorrow
    tomorrow_12am = Time.zone.local(tomorrow.year, tomorrow.mon, tomorrow.mday, 12, 0, 0)
    LineBot::ForUser::AtEvery12OclockWorker.perform_at tomorrow_12am
  end

  private

  def call_activities_the_day_before
    tommorow = Date.today + 1
    Activity.where(date: tommorow).each{|activity|
      activity.the_day_before()
    }
  end
end
