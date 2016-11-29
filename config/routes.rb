Rails.application.routes.draw do
  root to: 'top_pages#home'
  get    'signup', to: 'users#new'
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    root to: 'users#index'
    member do
      get :stock_recipe
      get :get_category
    end
  end
  
  resources :foods
  resources :stocks, only: [:create]
end
