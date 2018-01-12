Rails.application.routes.draw do
  resources :appointments, only: [:index, :show]
end
