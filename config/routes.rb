Rails.application.routes.draw do
  root to: 'todos#index'

  resources :users
  resources :todos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
