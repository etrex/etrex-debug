Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'http_requests#index'
  resources :http_requests, only: [:index, :show, :create]
  get    'create', to: 'http_requests#create'
  post   'create', to: 'http_requests#create'
  patch  'create', to: 'http_requests#create'
  put    'create', to: 'http_requests#create'
  delete 'create', to: 'http_requests#create'
  get    'delete', to: 'http_requests#delete'
end
