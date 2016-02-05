Rails.application.routes.draw do


  get 'instagram/authorize', to: 'instagram#authorize', as: 'authorize_instagram'
  get 'instagram/logged_in', to: 'instagram#logged_in', as: 'logged_in_instagram'
  resources :instagram

  match "/instagram_accounts/:username/get_user_media_interactions" => "instagram_accounts#get_user_media_interactions", via: :get
  get 'instagram_accounts/:id/get_followers', to: 'instagram_accounts#get_followers', as: 'get_followers_instagram'
  get 'instagram_accounts/to_follow', to: 'instagram_accounts#to_follow', as: 'to_follow_instagram'
  get 'instagram_accounts/get_token', to: 'instagram_accounts#get_token', as: 'get_token_instagram'
  resources :instagram_accounts
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
