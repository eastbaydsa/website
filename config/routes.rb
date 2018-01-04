Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :events, only: [:index, :show]

  get 'blog', to: 'blog_posts#index'
  get 'blog/*slug', to: 'blog_posts#show', as: 'blog_post'
  get '*slug', to: 'pages#show', as: 'page'
  root to: "pages#home"
end
