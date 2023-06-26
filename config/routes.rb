Rails.application.routes.draw do
  resources :memberships
  resources :gyms
  resources :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
