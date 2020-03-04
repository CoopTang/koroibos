Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :olympians, only: :index
      resource :olympian_stats, only: :show
      resources :events, only: :index do
        resources :medalists, only: :index
      end
    end
  end
end

