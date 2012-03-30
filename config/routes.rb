TicketMule::Application.routes.draw do
  # Root path
  root to: 'Dashboard#index'

  # Authentication
  get 'signin' => 'sessions#new', as: 'sign_in'
  delete 'signout' => 'sessions#destroy', as: 'sign_out'
  resources :sessions, only: [:new, :create]

  # Tickets
  resources :tickets
end
