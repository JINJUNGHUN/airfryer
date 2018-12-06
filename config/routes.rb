Rails.application.routes.draw do
  devise_for :users
  resources :post_attachments
  resources :posts
  root to: 'posts#index'

  get 'pages/about'
end
