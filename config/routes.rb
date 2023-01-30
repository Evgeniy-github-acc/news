Rails.application.routes.draw do
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#main_page"
  
  resources :posts do
    collection do
      get :main_page
    end
  end

  namespace :admin do
    resources :posts
    patch 'posts/:id/publish', to: 'posts#publish', as: 'publish_post'

    root "posts#index"
  end
end
