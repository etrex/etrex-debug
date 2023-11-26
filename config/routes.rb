Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'http_requests#index'
  resources :http_requests, only: [:index, :show, :create]

  get    'delete', to: 'http_requests#delete'
  get    'create', to: 'http_requests#create'

  # 所有路由
  match '*path', to: 'http_requests#create', via: :all
end
