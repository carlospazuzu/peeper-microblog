Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'statuses#index'
  get 'statuses', to: 'statuses#index', as: 'statuses'
  get 'statuses/new', to: 'statuses#new', as: 'new_status'
  get 'statuses/:id', to: 'statuses#show', as: 'status'
  get 'statuses/:id/edit', to: 'statuses#edit', as: 'edit_status'
  patch 'statuses/:id/', to: 'statuses#update', as: 'update_status'
  delete 'statuses/:id', to: 'statuses#destroy', as: 'destroy_status'
  post 'statuses', to: 'statuses#create', as: 'post_status'
end
