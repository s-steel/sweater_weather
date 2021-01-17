Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'weather#index'
      resources :backgrounds, only: [:index]
    end
  end
end
