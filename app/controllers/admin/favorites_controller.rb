class Admin::FavoritesController < ApplicationController
  def favorites_post
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page]).per(3).order('id DESC')
  end
end
