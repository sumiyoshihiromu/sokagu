Rails.application.routes.draw do
  
  get "posts/index" => "posts#index"
  get "posts/:id" => "posts#show"

  root "home#top"
  get "about" => "home#about"
  
end
