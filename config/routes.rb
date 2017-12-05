Rails.application.routes.draw do
  root 'books#home'
  get 'query1', to: 'books#query1', as: 'query1'
  get 'query2', to: 'books#query2', as: 'query2'
  get 'query3', to: 'books#query3', as: 'query3'
  get 'query4', to: 'books#query4', as: 'query4'
  get 'query5', to: 'books#query5', as: 'query5'
  get 'query6', to: 'books#query6', as: 'query6'
  get 'query7', to: 'books#query7', as: 'query7'
  get 'query8', to: 'books#query8', as: 'query8'
  get 'query9', to: 'books#query9', as: 'query9'


  resources :books_authors
  resources :library_rows
  resources :books
  resources :authors
  resources :shels
  resources :catalogs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
