Rails.application.routes.draw do

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/events', to: 'events#index', as: :events
  get '/events/:id/:slug', to: 'events#show', as: :event
  post '/events/:id/rsvp', to: 'events#rsvp', as: :rsvp

  get 'join' => 'static#join'

  get 'news', to: 'blog_posts#index', as: 'blog_posts'
  get 'news/:year/:month/:day/:slug', to: 'blog_posts#show', as: 'blog_post'
  post 'signup', to: 'signups#create', as: 'signup'
  get 'memberships/check', to: 'memberships#check'

  get 'r', to: 'application#handle_redirect'
  get 'unsubscribe', to: 'application#handle_unsubscribe'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_error'

  get '*slug', to: 'pages#show', as: 'page'
  root to: "pages#home"
end
