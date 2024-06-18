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
  get '/posts/timeline' => 'public/posts#timeline', as: 'timeline'
  patch 'users/withdraw' => 'public/users#withdraw', as: 'withdraw'
  get '/search' => 'public/searches#search', as: 'search'

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
    resources :notifications, only: [:update]
    resource :map, only:[:show]
  end


  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    get '/users/:id/userpost' => 'users#userpost', as: 'userpost'
    get '/search' => 'searches#search'

    resources :posts, only:[:show, :destroy] do
      resources :post_comments, only:[:destroy]
    end
    resources :users, only:[:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
