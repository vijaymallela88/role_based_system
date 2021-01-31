Rails.application.routes.draw do
  
  resources :employees
  resources :roles
  resources :products
  # root :to => 'users#sign_in'
  root :to => 'home#index'
  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
