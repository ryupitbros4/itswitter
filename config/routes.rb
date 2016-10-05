Rails.application.routes.draw do
  
  get 'userpage/display'
  get 'userpage/display2'
  get "userpage/display" => "userpage#display"
  resources :restaurants
  root 'restaurants#index'

end
