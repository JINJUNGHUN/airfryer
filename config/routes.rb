Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }


  resources :post_attachments
  resources :posts
  root to: 'posts#index'

  get 'pages/about'
end
