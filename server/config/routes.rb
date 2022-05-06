Rails.application.routes.draw do
  
  root :to => "home#index"
  get("/home", {to: "home#index"})
  get("/about", {to: "about#index"})
  get("/contact", {to: "contact#index"})
  post("/contact_submit", {to: "contact#create", as: "contact_submit"})
  get("/bill", {to: "bill#index"})
  post("/bill_submit", {to: "bill#index", as: "bill_submit"})
  get("/admin/panel", {to: "admin#index"})
  get("/admin/user/:id", {to: "admin#show", as: "user_ip"})


  resources :products do
    resources :reviews, shallow: :true, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :votes, only: [:create, :destroy]
    end
    resources :favourites, shallow: :true, only: [:create, :destroy]
  end
  resources :favourites, only: [:index]
  resources :tags, only: [:index, :show]
  resources :users, only:[:new, :create, :show]
  resource :session, only:[:new, :create, :destroy]
  
  # get 'products' => 'products#index'
  # get 'products/new' => 'products#new', as: :new_product
  # post 'products' => 'products#create'
  # delete 'products/:id' => 'products#destroy'
  # get 'products/:id' => 'products#show', as: :product
  # get 'products/:id/edit' => 'products#edit', as: :edit_product
  # patch 'products/:id' => 'products#update'
  resources :news_articles, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products, only:[:index, :show, :update, :create, :destroy]
      resource :session, only:[:create,:destroy]
      get('/current_user', to: 'sessions#get_current_user')
      resources :users, only: [:create]
    end
  end
end
