Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    member do
      resources :comments, only: [:index, :new, :create]
    end
  end
end
