Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]
  resources :subs
  resources :posts, except: [:index]
end
