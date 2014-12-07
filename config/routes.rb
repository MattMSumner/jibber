Rails.application.routes.draw do
  namespace :v1 do
    resources :sessions, only: [:create]
  end
end
