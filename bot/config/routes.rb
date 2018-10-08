Rails.application.routes.draw do
  post '/line/callback', to: 'line_bot_webhook#callback'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
