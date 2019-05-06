Rails.application.routes.draw do
  resources :datum, only: [:index, :new, :create, :destroy]
  post '/datum/new', to: 'datum#create'
  root 'datum#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
