class Public::FavoritesController < ApplicationController
  # お気に入り登録
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end
  # お気に入りを解除
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

end
