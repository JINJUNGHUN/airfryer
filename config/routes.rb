Rails.application.routes.draw do
  resources :post_attachments
  resources :posts
  root to: 'posts#index'
end
