require 'sidekiq/web'
Rails.application.routes.draw do
  
  # linebot callback
  post '/line/callback', to: 'bot/line_webhook#callback'
  
  mount Sidekiq::Web, at: '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # static pages
  get 'static_pages/test', to: 'webapp/static_pages#test'
  get 'landing/circle', to: 'webapp/static_pages#landing_circle'
  get 'landing/user', to: 'webapp/static_pages#landing_user'

  # users
  get 'users/login_as_circle', to: 'webapp/users#login_as_circle'
  get 'users/login_as_user', to: 'webapp/users#login_as_user'
  post 'users/login', to: 'webapp/users#login'
  post 'users/logout', to: 'webapp/users#logout'

  # cricles
  get 'circles/new', to: 'webapp/circles#new'
  post 'circles', to: 'webapp/circles#create'
  get 'circles/:cricle_id/edit', to: 'webapp/circles#edit'
  patch 'circles/:circle_id', to: 'webapp/circles#update'

  # activities
  get 'circles/:circle_id/activities/new', to: 'webapp/activities#new'
  post 'circles/:circle_id/activities/', to: 'webapp/activities#create'
  get 'circles/:circle_id/activities/:activity_id/edit', to: 'webapp/activities#edit'
  patch 'circles/:circle_id/activities/:activity_id', to: 'webapp/activities#update'
  delete 'circles/:circle_id/activities/:activity_id', to: 'webapp/activities#destroy'
  get 'circles/:circle_id/activities/:activity_id', to: 'webapp/activities#show'
  
  # message
  get 'circles/:circle_id/activities/:activity_id/user_blocks/new', to: 'webapp/user_blocks#new'
  post 'circles/:circle_id/activities/:activity_id/user_blocks', to: 'webapp/user_blocks#create'

  #applications
  post 'circles/:circle_id/activities/:activity_id/applications/', to: 'webapp/applications#create'
  delete 'circles/:circle_id/activities/:activity_id/applications/:application_id', to: 'webapp/applications#destroy'

  # reviews
  get 'circles/:circle_id/activities/:activity_id/review/new', to: 'webapp/reviews#new'
  post 'circles/:circle_id/activities/:activity_id/review', to: 'webapp/reviews#create'

  #chats
  get 'circles/:circle_id/activities/:activity_id/applications/:application_id/chats', to: 'webapp/chats#list'
  post 'circles/:circle_id/activities/:activity_id/applications/:application_id/chats', to: 'webapp/chats#create'

end
