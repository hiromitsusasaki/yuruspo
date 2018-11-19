Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, ENV['YURUSPO_LINE_CHANNEL_FOR_LOGIN_KEY'], ENV['YURUSPO_LINE_CHANNEL_FOR_LOGIN_SECRET']
end