Rails.application.routes.draw do

  namespace :public do
    get 'maps/show'
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
  scope module: :public do
    resource :maps, only:[:show], as: 'map'
  end
  

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
