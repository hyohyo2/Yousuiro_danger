Rails.application.routes.draw do
  # ユーザ用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post '/users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  # ユーザ用
  root to: "public/homes#top"
  get '/about' => 'public/homes#about'
  get '/users/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'
  get '/users/:id/userpost' => 'public/users#userpost', as: 'userpost'
  get '/posts/timeline' => 'public/posts#timeline', as: 'timeline'
  patch 'users/withdraw' => 'public/users#withdraw', as: 'withdraw'
  get '/search' => 'public/searches#search', as: 'search'
  # 新規登録失敗時の遷移先
  get '/users' => redirect("/users/sign_up")
  get '/posts' => redirect('/posts/new')

  scope module: :public do
    resources :users, only:[:show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only:[:create, :destroy]
        get 'followings' => 'relationships#followings'
        get 'followers' => 'relationships#followers'
    end
    resources :posts, only:[:new, :create, :show, :edit, :update, :destroy] do
      resources :post_comments, only:[:create, :destroy]
      resource :favorite, only:[:create, :destroy]
    end
    resources :chats, only:[:show, :create, :destroy]
    resources :rooms, only:[:index]
    resources :notifications, only:[:index, :destroy, :update]
    resource :map, only:[:show]
  end


  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    get '/users/:id/userpost' => 'users#userpost', as: 'userpost'
    get '/search' => 'searches#search'
    get '/users/:id/followings' => 'relationships#followings', as: 'followings'
    get '/users/:id/followers' => 'relationships#followers', as: 'followers'
    get '/users/:id/favorites' => 'users#favorites', as: 'favorite'

    resources :posts, only:[:show, :destroy] do
      resources :post_comments, only:[:destroy]
    end
    resources :users, only:[:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
