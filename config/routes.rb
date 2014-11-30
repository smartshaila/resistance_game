Rails.application.routes.draw do
  resources :role_relationships
  resources :mission_capacities
  resources :lancelots
  resources :ladies
  resources :team_assignments
  resources :team_votes
  resources :teams
  resources :missions
  resources :player_assignments do
    get 'revealed_info', on: :member
    get 'game_state', on: :member
    get 'current_action', on: :member
    post 'team_vote', on: :member
    post 'assign_team', on: :member
    post 'mission_vote', on: :member
    get 'game_log', on: :member
    post 'assassinate', on: :member
  end
  resources :roles
  resources :factions
  resources :players
  resources :games
  get 'login', to: 'login#index'
  post 'login', to: 'login#login'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'login#index'

  get '/teams/:team_id/team_votes/:player_assignment_id/new', to: 'team_votes#new', as: 'vote_on_team'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
