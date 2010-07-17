ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'dashboard'

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :tickets, :has_many => [:comments, :attachments]

  map.connect 'tickets/set_tickets_per_page/:per_page', :controller => 'tickets', :action => 'set_tickets_per_page'

  map.connect 'attachments/:ticket_id/:id', :controller => 'attachments', :action => 'show', :conditions => { :method => :get }

  map.resources :dashboard, :only => :index

  # users can add themselves
  map.resources :users, :member => { :toggle => :post, :unlock => :post }

  # only admins can add users
  #map.resources :users, :member => { :toggle => :post }, :except => :new

  map.resources :contacts, :member => { :toggle => :post }

  map.resource :user_session

  map.resources :password_resets

  map.resources :alerts

  map.with_options :controller => 'admin' do |a|
    a.admin_index '/admin', :action => 'index', :conditions => { :method => :get }
    a.add_group '/admin/add_group', :action => 'add_group', :conditions => { :method => :post }
    a.add_status '/admin/add_status', :action => 'add_status', :conditions => { :method => :post }
    a.add_priority '/admin/add_priority', :action => 'add_priority', :conditions => { :method => :post }
    a.add_user '/admin/add_user', :action => 'add_user', :conditions => { :method => :post }
    a.toggle_group '/admin/toggle_group', :action => 'toggle_group', :conditions => { :method => :post }
    a.toggle_status '/admin/toggle_status', :action => 'toggle_status', :conditions => { :method => :post }
    a.toggle_priority '/admin/toggle_priority', :action => 'toggle_priority', :conditions => { :method => :post }
  end

  map.connect '*url', :controller => 'dashboard', :action => 'index'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
