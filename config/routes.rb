Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    post "/sessions" => "sessions#create"

    get "/users" => "users#index"
    post "/users" => "users#create"
    get "/users/:id" => "users#show"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    get "/coverages" => "coverages#index"

    post "/img_videos" => "img_videos#create"
    get "/img_videos/:id" => "img_videos#show"
    delete "/img_videos/:id" => "img_videos#destroy"

    get "/categories" => "categories#index"
    post "/categories" => "categories#create"
    get "/categories/:id" => "categories#show"
    patch "/categories/:id" => "categories#update"
    delete "/categories/:id" => "categories#destroy"

    get "/user_categories" => "user_categories#index"
    post "/user_categories" => "user_categories#create"
    post "/user_categories" => "user_categories#destroy"

    get "/skills" => "skills#index"
    post "/skills" => "skills#create"

    get "/user_skills" => "user_skills#index"
    post "/user_skills" => "user_skills#create"
    post "/user_skills" => "user_skills#destroy"

    get "/calendars" => "calendars#index"
    post "/calendars" => "calendars#create"
    get "/calendars/:id" => "calendars#show"
    patch "/calendars/:id" => "calendars#update"
    delete "/calendars/:id" => "calendars#destroy"

    get "/experiences" => "experiences#index"
    post "/experiences" => "experiences#create"
    get "/experiences/:id" => "experiences#show"
    patch "/experiences/:id" => "experiences#update"
    delete "/experiences/:id" => "experiences#destroy"

    get "/messages" => "messages#index"
    post "/messages" => "messages#create"
    get "/messages/:id" => "messages#show"
    patch "/messages/:id" => "messages#update"
    delete "/messages/:id" => "messages#destroy"

    get "/replies" => "replies#index"
    post "/replies" => "replies#create"
    get "/replies/:id" => "replies#show"
    patch "/replies/:id" => "replies#update"
    delete "/replies/:id" => "replies#destroy"
  end
end
