Rails.application.routes.draw do

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  constraints CanAccessFlipperUI do
    mount Flipper::UI.app(Flipper) => '/admin/flipper'
  end

  constraints(:host => /oaklandbreadfored.org/) do
    match "/(*path)" => redirect {|params, req| "https://eastbaydsa.org/campaigns/bread-for-ed"}, via: [:get, :post]
  end

  get '/events', to: 'events#index', as: :events
  get '/events/:id/:slug', to: 'events#show', as: :event
  post '/events/:id/rsvp', to: 'events#rsvp', as: :rsvp

  get 'join' => 'static#join'
  get 'donate' => 'static#donate'

  get 'news', to: 'blog_posts#index', as: 'blog_posts'
  get 'news/:year/:month/:day/:slug', to: 'blog_posts#show', as: 'blog_post'
  post 'signup', to: 'signups#create', as: 'signup'

  ###### API #####
  post 'external/signup-majority', to: 'signups#signup_majority', constraints: lambda { |req| req.format == :json }
  get 'memberships/check', to: 'memberships#check'
  ################

  ## External/Legacy support ##
  get 'r', to: 'application#handle_redirect'
  get 'unsubscribe', to: 'application#handle_unsubscribe'
  #############################

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_error'

  get 'auth/oauth2/callback' => 'auth0#callback'
  get 'auth/logout' => 'auth0#logout'
  get 'auth/failure' => 'auth0#failure'

  get '*slug', to: 'pages#show', as: 'page'

  root to: "home#index"
end
