class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to admin_user_path(@post.user)
    else
      flash.now[:alert] = "投稿内容の削除に失敗しました。"
      render :show
    end
  end
end
