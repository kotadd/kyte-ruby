Rails.application.routes.draw do
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  post "likes/:post_id/create_index" => "likes#create_index"
  post "likes/:post_id/destroy_index" => "likes#destroy_index"
  post "likes/:post_id/:genre_id/create_detail" => "likes#create_detail"
  post "likes/:post_id/:genre_id/destroy_detail" => "likes#destroy_detail"

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
  get "forgot_password" => "users#forgot_password_form"
  post "forgot_password" => "users#forgot_password"

  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"
  get "users/:id/joins" => "users#joins"
  get "users/:id/joined" => "users#joined"
  get "users/:id/likes" => "users#likes"

  get "posts/:id/index" => "posts#detail"
  get "posts/date" => "posts#date"
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  # post "posts/change_date" => "posts#change_date"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id/destroy" => "posts#index"
  get "posts/create" => "posts#new"
  get "posts/:id/update" => "posts#edit"
  get "posts/:id" => "posts#show"

  get "/" => "pages#top"
  get 'about' => 'pages#about'
  # get 'contact' => 'pages#contact'


end
