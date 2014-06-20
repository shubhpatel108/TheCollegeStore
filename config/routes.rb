TheCollegeStore::Application.routes.draw do
  root to: 'application#check_cookies'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/city_vendors/login', to: 'city_vendors#login', as: :city_vendor_login
  get '/city_vendors/logout', to: 'city_vendors#logout', as: :city_vendors_logout
  post '/city_vendors/login', to: 'city_vendors#auth', as: :city_vendor_authenticate
  resources :city_vendors
  get '/city_vendors/new_password', to: 'city_vendors#new_password', as: :reset_password
  post '/city_vendors/new_password', to: 'city_vendors#reset_password', as: :reset_password
  get "emailapi/index"
  post "emailapi/subscribe" => 'emailapi#subscribe'
  resources :books do
    collection do
      post 'request_seller'
    end
  end
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations"}
  get '/search', to: 'books#main_search', as: :search
  get '/person_category', to: 'application#person_category'
  get '/application/select_college', to: 'application#select_college'
  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end
  resources :colleges do
    collection do
      post 'request_admin_to_add_college'
    end
  end
  get '/books/sell/new_book', to: 'books#sell'
  post '/books/sell/autofill', to: 'books#sell_autofill'
  resources :book_groups
  get '/book_groups/details/:id', to: 'book_groups#details', as: :book_detail
  get '/add_item/:id', to: 'cart#add_item', as: :add_item
  get '/cart/show', to: 'cart#show_cart', as: :show_cart
  get '/cart/remove_item/:id', to: 'cart#remove_item', as: :remove_item
  get '/cart/checkout', to: 'cart#checkout', as: :checkout
  get '/coupons', to: 'coupons#index', as: :coupons
  get '/coupons/add_coupon/:id', to: 'coupons#add_coupon', as: :add_coupon
  get '/coupons/remove_coupon/:id', to: 'coupons#remove_coupon', as: :remove_coupon
  get '/book_groups/category/:id', to: 'book_groups#category_books', as: :category_books
  get '/book_groups/categories/all', to: 'book_groups#all_categories', as: :all_categories
  
  get '/wishlist/add/:id', to: 'wishlists#add', as: :add_to_wishlist
  get '/wishlist/remove/:id', to: 'wishlists#remove', as: :remove_to_wishlist
  get '/wishlist/show', to: 'wishlists#show', as: :wishlist
  get '/city_vendors/sell', to: 'book_groups#new', as: :city_vendor_sell
  post '/city_vendors/sell', to: 'book_groups#create'
  resources :guests
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
