class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  # 投稿詳細
  def show
    @post = Post.find(params[:id])
  end
  
  # 投稿削除
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
