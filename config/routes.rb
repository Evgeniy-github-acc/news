Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "admin/posts#index"

  namespace :admin do
    resources :posts
    patch 'posts/:id/publish', to: 'posts#publish', as: 'publish_post'
  end
end
