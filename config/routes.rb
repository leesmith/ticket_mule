TicketMule::Application.routes.draw do
  root to: 'Dashboard#index'

  get 'sign-in' => 'sessions#new', as: 'sign_in'

  resources :sessions, only: [:new, :create]
end
