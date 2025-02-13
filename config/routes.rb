Rails.application.routes.draw do
  
  post "bookmarks/:post_id/create" => "bookmarks#create"
  post "bookmarks/:post_id/destroy" => "bookmarks#destroy"
  
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  
  get "signup" => "users#new"
  get "users/:id" => "users#show"
  
  get "users/:id/bookmarks" => "users#bookmarks"
  get "users/:id/messages" => "users#messages"
  
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  root "home#top"
  get "about" => "home#about"
  
end
