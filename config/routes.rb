Rails.application.routes.draw do

  namespace :public do
    get 'posts/new'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/timeline'
  end
  # ユーザ用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  # ユーザ用
  root to: "public/homes#top"
  get '/about' => 'public/homes#about'
  get '/users/my_page' => 'public/users#mypage', as: 'mypage'
  get '/users/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'
  get '/posts/timeline' => 'public/posts#timeline', as: 'timeline'
  patch 'users/withdraw' => 'public/users#withdraw', as: 'withdraw'

  scope module: :public do
    resources :users, only:[:show, :edit, :update]
    resources :posts, only:[:new, :create, :show, :edit, :update, :destroy]
    resource :maps, only:[:show]
  end


  # 管理者用
  namespace :admin do
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
