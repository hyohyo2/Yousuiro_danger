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
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
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
      flash[:notice] = "投稿内容を更新しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿内容の更新に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to mypage_path
    else
      flash.now[:alert] = "投稿内容の削除に失敗しました。"
      render :show
    end
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
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to timeline_path
    end
  end
  
end
