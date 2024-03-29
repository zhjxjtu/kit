Kit::Application.routes.draw do

  root to: 'webpages#landing'

  resources :users, only: [:new, :create, :index, :update, :show, :destroy]
  match '/signup',  to: 'users#new'

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  resources :invitations, only: [:index, :create]
  match '/invitations_new_signup', to: 'invitations#new_signup'
  match '/invitations_accept_signup', to: 'invitations#accept_signup', via: :post
  match '/invitations_new_signin', to: 'invitations#new_signin'
  match '/invitations_accept_signin', to: 'invitations#accept_signin', via: :post

  resources :contacts, only: [:index]
  
  resources :passwords, only: [:new, :create, :edit, :update]
  match '/reset_new',  to: 'passwords#reset_new'
  match '/reset_update',  to: 'passwords#reset_update', via: :put

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
