Rails.application.routes.draw do

  resources :my, only: [:index]
  get 'my/my_log' => 'my#my_log', as: :my_my_log

  get 'my/favorites', as: :favorite_restaurants

  post 'restaurants/:restaurant_id/follow' => 'my#follow', as: :follow_restaurant
  post 'restaurants/:restaurant_id/unfollow' => 'my#unfollow', as: :unfollow_restaurant

  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get "/auth/failure" => "sessions#failure"
  
  get 'restaurants/slide_info'
  get 'demands/index'
  get 'demands/index_approved', as: :approved_demands
  post 'demands/index' => 'demands#new', as: :demands_new
  
  post 'restaurants/search' => 'restaurants#search', as: :restaurants_search
  get 'restaurants/search' => 'restaurants#index'
  get 'restaurants/tell_search' => 'restaurants#tell_index', as: :tell_index
  post 'restaurants/tell_search' => 'restaurants#tell_search', as: :tell_search

  get 'restaurants/user_ranking' 
  get 'restaurants/comment_log'
  post 'restaurants/comment_log', as: :comment_log

  get 'restaurants/shop_info', as: :shop_info
  
  #post 'add_like_point', as: :add_like_point
  #post 'cancel_like', as: :cancel_like
  
  resources :restaurants do 
    collection do
      get 'report'
      post 'deliver'      
      get 'treatment'
      post 'add_like_point'
      post 'cancel_like'
      get 'all_rest'
      post 'rest_ind'
      post 'rest_show'

      
      get 'promotion'
      get 'slide_explain'
    end
  end
  
  
  root 'restaurants#index'

  get "investigators/new" => 'investigators#new', as: :new_investigators
  post "investigators" => 'investigators#create', as: :invest_update
  delete "investigators/:id" => 'investigators#destroy', as: :delete
  get "investigators/delete"
  get "investigators/show/:id" => 'investigators#show', as: :show_investigators
  patch "investigators/:id" => 'investigators#update', as: :update_investigators
  get "investigators/opening_hour_new/:restaurant_id" => 'investigators#opening_hour_new', as: :opening_hour_new
  post "investigators/opening_hour_new/" => 'investigators#opening_hour_create', as: :opening_hour_create
  delete "investigators/opening_hour_delete/:id" => 'investigators#opening_hour_destroy', as: :opening_hour_delete

  # Admin
  get "admin" => 'admin#index'
  get "admin/index" => 'admin#index', as: :admin_index
  put "admin/demands/:id/archive" => 'admin#archive_demand', as: :admin_archive_demand
  put "admin/demands/:id/unarchive" => 'admin#unarchive_demand', as: :admin_unarchive_demand

  resources :feedbacks
  resources :renewals
  delete "renewals/:id" => 'renewals#destroy', as: :renewal_delete
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

end
