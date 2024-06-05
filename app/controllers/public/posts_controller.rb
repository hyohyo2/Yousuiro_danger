class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @current_user = current_user
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to timeline_path
  end

  def timeline
    @current_user = current_user
    # 後でフォローしている人と自分の投稿のみ表示にする
    @posts = Post.page(params[:page]).per(10)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :post_code, :prefecture_address, :city_address, :block_address, :detail, :status)
  end
  
end
