Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"
end
