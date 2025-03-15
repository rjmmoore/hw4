Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })
  get "/login", to: "sessions#new"
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"
end
