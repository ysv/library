Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :shels
  resources :catalogs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
