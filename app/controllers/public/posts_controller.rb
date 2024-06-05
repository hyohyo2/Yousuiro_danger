class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]
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
     @current_user = current_user
  end
  
  def update
    @current_user = current_user
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
  
  # 他ユーザからのアクセスの制限
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to timeline_path
    end
  end
  
end
