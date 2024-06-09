class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "投稿内容の削除に失敗しました。"
      render :show
    end
  end
end
