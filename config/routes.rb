Rails.application.routes.draw do

  namespace :api do

    resources :users, only: [] do
      resources :shorturls, only: [:index, :show, :create, :destroy]
    end

    resources :shorturls, only: [] do
      resources :shortvisits, only: [:index, :show] do
        member do
          get 'geolocate'
        end
      end
    end
    
  end

  resources :sessions, only: [:new, :create]

  get 'sessions/new' => 'sessions#new', as: :signin
  get 'sessions/destroy' => 'sessions#destroy', as: :signout

  resources :users, only: [:new, :create] do
    resources :shorturls, only: [:index, :show, :new, :create, :destroy]
  end

  get '/users/new' => 'users#new', as: :signup

  resources :shorturls, only: [] do
    resources :shortvisits, only: [:index, :show] do
      member do
        get 'geolocate'
      end
    end
  end

  get ':id' => 'shorturls#redirect_to_short'

  root 'home#welcome'

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
