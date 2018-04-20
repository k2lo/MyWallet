Rails.application.routes.draw do
  
  resources :categories do
    resources :expenses
  end
  
  resources :settings
  devise_for :users
  
  get 'new_basic', to: 'categories#create_basic_categories'
  
  root to: "pages#info"
  
end
