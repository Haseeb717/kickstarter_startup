Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :products do
    member do 
      get 'back'
      get 'report'
      get 'like'
    end
    collection do
      get 'favorite'
      get 'popular'
      get 'recommended'
    end
  end 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks",registrations: 'registrations' }
  root 'home#index'

  get 'my_projects' =>'products#my_products'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
