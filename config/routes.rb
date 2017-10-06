Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'blog', to: 'blog#index'
  get 'blog/*slug', to: 'blog#show'
  get '*slug', to: 'pages#show'
  root to: "pages#home"
end
