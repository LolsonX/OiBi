Rails.application.routes.draw do
  resources :datum, only: [:index, :new, :create, :destroy]
  resources :encrypted_file, only: [:index, :new, :create, :destroy]
  post '/datum/new', to: 'datum#create'
  post '/encrypted_file/new', to: 'encrypted_file#create'
  root 'welcome#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
