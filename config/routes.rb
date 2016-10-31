Rails.application.routes.draw do
  get 'restaurants/slide_info'
  get 'demands/index'
  get 'demands/index_approved', as: :approved_demands
  post 'demands/index' => 'demands#new', as: :demands_new
  
  post 'restaurants/search' => 'restaurants#search', as: :restaurants_search
  get 'restaurants/search' => 'restaurants#index'
  
  resources :restaurants do 
    collection do
      get 'report'
      post 'deliver'
    end
  end 
  root 'restaurants#index'

  get "investigators/index"
  post "investigators/:id" => 'investigators#update', as: :dbupdate
  get "investigators/new" => 'investigators#new', as: :new_investigators
  post "investigators" => 'investigators#create', as: :invest_update
  delete "investigators/:id" => 'investigators#destroy', as: :delete
  get "investigators/delete"


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
