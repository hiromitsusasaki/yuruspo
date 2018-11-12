require 'sidekiq/web'
Rails.application.routes.draw do
  post '/line/callback', to: 'bot/line_webhook#callback'
  mount Sidekiq::Web, at: '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
