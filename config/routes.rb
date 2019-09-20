Rails.application.routes.draw do
  get '/users/login_form',to: 'users#login_form'
  post '/users/login',to: 'users#login'

  root 'home#index'
  
  post '/add_likes/:id',to: 'likes#add_like'
  post '/not_likes/:id',to: 'likes#not_like'
  get '/likes/index', to: 'likes#index'
  
  post '/recommend/:id',to: 'recommends#add_recommend'
  post '/no_recommend/:id',to: 'recommends#remove_recommend'
  
  
  post '/comments/:book_id',to: 'comments#create'
  get '/books/search',to: 'books#search'
  resources :users, except: :edit
  resources :books
  get '/users/:id/detail_edit',to: 'users#detail_edit'
  post '/users/:id/detail_update',to: 'users#detail_update'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
