Fruitback::Application.routes.draw do

  root to: "static_pages#home"
  match '/about', to: 'static_pages#about'
  match '/help', to: 'static_pages#help'
  
  devise_for :users, controllers: {
    registrations: "registrations",
    confirmations: "confirmations",
    passwords: "passwords",
    sessions: "sessions" }
  
  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end
  
  match '/profiles/check', to: 'profiles#check'
  match '/profiles/:id/confirm', to: 'profiles#confirm', as: :profiles_confirm
  match '/profiles/:id/upgrade', to: 'profiles#upgrade', as: :profiles_upgrade
  match '/customer_sites/:id/backup', to: 'customer_sites#backup', as: :backup
  
  resources :profiles
  
  resources :sites do
    resources :ideas do
      resources :comments
      resources :votes
    end
  end
  
  match '/customer_sites/:id/widget', to: 'customer_sites#widget'
  resources :customer_sites do
    resources :customer_ideas do
      resources :customer_comments
      resources :customer_responses
    end
  end
  
  resources :micro_sites do 
    resources :micro_ideas
  end
  
  
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
