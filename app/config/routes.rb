require 'sidekiq/web'
Rails.application.routes.draw do

  # top page
  root 'webapp/static_pages#index'

  # line login
  get 'auth/:provider/callback', to: 'webapp/sessions#create'

  # linebot callback
  post '/line/callback_for_user', to: 'bot/line_webhook#callback_for_user'
  post '/line/callback_for_circle', to: 'bot/line_webhook#callback_for_circle'

  mount Sidekiq::Web, at: '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # static pages
  get 'static_pages/test', to: 'webapp/static_pages#test'
  get 'landing/circle', to: 'webapp/static_pages#landing_circle'
  get 'landing/user', to: 'webapp/static_pages#landing_user'

  # users
  get 'users/login_as_circle', to: 'webapp/users#login_as_circle'
  get 'users/login_as_user', to: 'webapp/users#login_as_user'
  get 'users/loggedin_as_user', to: 'webapp/users#loggedin_as_user'

  # sessions
  post '/login_by_user_id', to: 'webapp/sessions#login_by_user_id'
  get '/logout', to: 'webapp/sessions#destroy'

  # cricles
  get 'circles/new', to: 'webapp/circles#new'
  post 'circles', to: 'webapp/circles#create'
  get 'circles/:circle_id/edit', to: 'webapp/circles#edit'
  patch 'circles/:circle_id', to: 'webapp/circles#update'
  get 'circles/:circle_id', to: 'webapp/circles#show'

  # activities
  get 'circles/:circle_id/activities/new', to: 'webapp/activities#new'
  post 'circles/:circle_id/activities/', to: 'webapp/activities#create'
  get 'circles/:circle_id/activities/:activity_id/edit', to: 'webapp/activities#edit'
  patch 'circles/:circle_id/activities/:activity_id', to: 'webapp/activities#update'
  delete 'circles/:circle_id/activities/:activity_id', to: 'webapp/activities#destroy'
  get 'circles/:circle_id/activities/:activity_id', to: 'webapp/activities#show'

  # messages
  post 'circles/:circle_id/activities/:activity_id/messages', to: 'webapp/messages#create'

  # user_blocks
  get 'circles/:circle_id/activities/:activity_id/user_blocks/new', to: 'webapp/user_blocks#new'
  post 'circles/:circle_id/activities/:activity_id/user_blocks', to: 'webapp/user_blocks#create'

  #applications
  post 'circles/:circle_id/activities/:activity_id/applications/', to: 'webapp/applications#create'
  delete 'circles/:circle_id/activities/:activity_id/applications/:application_id', to: 'webapp/applications#destroy'
  get 'circles/:circle_id/activities/:activity_id/applications/:application_id', to: 'webapp/applications#show'

  # reviews
  get 'circles/:circle_id/activities/:activity_id/reviews/new', to: 'webapp/reviews#new'
  post 'circles/:circle_id/activities/:activity_id/reviews', to: 'webapp/reviews#create'
  get 'circles/:circle_id/activities/:activity_id/reviews/complete', to: 'webapp/reviews#complete'

  #chats
  post 'circles/:circle_id/activities/:activity_id/applications/:application_id/chats', to: 'webapp/chats#create'

  #owned_circle
  get 'owned_circle', to: 'webapp/redirect#to_owned_circle_show'
  get 'owned_circle/activities/new', to: 'webapp/redirect#to_owned_circle_activities_new'
end
