TicketMule::Application.routes.draw do
  root to: 'Dashboard#index'

  get 'sign-in' => 'sessions#new', as: 'sign_in'
  delete 'sign-out' => 'sessions#destroy', as: 'sign_out'

  resources :sessions, only: [:new, :create]
end
