Rails.application.routes.draw do
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  post "members/:post_id/create" => "members#create"
  post "members/:post_id/destroy" => "members#destroy"

  post "genres/:id/update" => "genres#update"
  get "genres/:id/edit" => "genres#edit"
  post 'genres/create' => 'genres#create'
  get 'genres/create' => 'genres#new'
  get 'genres/index' => 'genres#index'

  post "users/:id/update" => "users#update"
  get "users/:id/update" => "users#edit"
  post "users/:id/update_password" => "users#update_password"
  get "users/:id/update_password" => "users#password"
  get "users/:id/password" => "users#password"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "users/create" => "users#new"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"
  get "users/:id/joins" => "users#joins"
  get "users/:id/likes" => "users#likes"

  get "posts/:id/index" => "posts#detail"
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/create" => "posts#new"
  get "posts/:id/update" => "posts#edit"
  get "posts/:id" => "posts#show"

  get "/" => "pages#top"
  get 'about' => 'pages#about'
  # get 'contact' => 'pages#contact'


end
