class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]
  before_action :ensure_guest_user, except:[:show, :timeline]
  def new
    @post = Post.new
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
    # コメント機能の記述
    @post_comment = PostComment.new
    @post_comments = PostComment.all
  end

  def edit
    @post = Post.find(params[:id])
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
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "投稿内容の削除に失敗しました。"
      render :show
    end
  end

  def timeline
    respond_to do |format|
      format.html do
        # 後でフォローしている人と自分の投稿のみ表示にする
        # 新着順
        @posts = Post.where(user_id: [current_user.id] + current_user.followings.pluck(:id)).page(params[:page]).per(10).order('id DESC')
      end
      format.json do
        @posts = Post.all
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :post_code, :prefecture_address, :city_address, :block_address, :detail, :status)
  end

  # 他ユーザからのアクセスの制限
  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to post_path(@post.id)
    end
  end

# ゲストログイン時のアクセス制限
  def ensure_guest_user
    if current_user.guest_user
      redirect_to user_path(current_user.id), alert: "ゲストユーザーはご利用できません。"
    end
  end

end
