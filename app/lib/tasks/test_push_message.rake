namespace :test_push_message do
  task :text_for_user => :environment do
    user_id = ENV['MY_OWN_LINE_USER_ID']
    messages = [{type: 'text', text: 'test push message'}]
    LineBot::ForUser::PushWorker.new.perform(user_id, messages)
  end
  task :text_for_circle => :environment do
    p user_id = ENV['MY_OWN_LINE_USER_ID']
    messages = [{type: 'text', text: 'test push message'}]
    LineBot::ForCircle::PushWorker.new.perform(user_id, messages)
  end
end
