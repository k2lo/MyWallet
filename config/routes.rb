Rails.application.routes.draw do
  
  resources :categories do
    resources :expenses
  end
  
  resources :settings
  devise_for :users
  
  get 'new_basic', to: 'categories#create_basic_categories'
  get 'info', to: 'pages#info'
  
  root to: "categories#index"
  
end
