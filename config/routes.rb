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


  # ユーザ用
  root to: "public/homes#top"
  get '/about' => 'public/homes#about'
  get '/users/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'
  get '/posts/timeline' => 'public/posts#timeline', as: 'timeline'
  patch 'users/withdraw' => 'public/users#withdraw', as: 'withdraw'
  get '/search' => 'public/searches#search', as: 'search'

  scope module: :public do
    resources :users, only:[:show, :edit, :update]
    resources :posts, only:[:new, :create, :show, :edit, :update, :destroy] do
      resources :post_comments, only:[:create, :destroy]
    end
    resource :maps, only:[:show]
  end


  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    get '/users/:id/userpost' => 'users#userpost', as: 'userpost'

    resources :posts, only:[:show, :destroy] do
      resources :post_comments, only:[:destroy]
    end
    resources :users, only:[:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
