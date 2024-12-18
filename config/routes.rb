Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "product/:id", to: "home#show", as: "product"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    root to: "dashboard#redirect_based_on_auth"
    resources :products do
      member do
        delete :delete_image
      end
    end
    resources :categories, only: [ :index, :create, :destroy ]
    resources :sales do
      collection do
        post :update_product_list
        post :clear_product_list
      end
    end
    resources :users
  end
end
