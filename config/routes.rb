Stalkmore::Application.routes.draw do

  root to: "posts#index"
  get "/welcome", to: "sessions#welcome", as: :welcome
  post "/feeds", to: "feeds#create", as: :feed
  get "/search/tumbles", to: "tumbles#search", as: :tumbles
  # get "users/sign_in", to: redirect("/auth/developer"), as: :sign_in
  # get "/users/sign_out", to: "sessions#sign_out", as: :sign_out
  # get "/auth/:provider/callback", to: "sessions#create"
  # post "/auth/:provider/callback", to: "sessions#create" # This is what the below 'match' method does.
  match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]
  # get "/auth/:provider", to: "sessions#show"
  get "/test", to: "test#index"
  get "/sign_in", to: "sessions#sign_in", as: :sign_in
  get "/sign_out" => "sessions#sign_out", :as => :sign_out



  #twitter search feature
  get "/twitter/search", to: "twitter#search"

  post "/twitter/posttweet", to: "twitter#posttweet"

  # rss search
  get "rss/search", to: "rss#search"


 post "rss/create", to: "rss#create"

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
