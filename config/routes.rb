Rails.application.routes.draw do
  post "notify", to: "notifier#create", defaults: {format: :json}
  get "projects/:id/stats", to: "statistics#index", defaults: {format: :json}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
