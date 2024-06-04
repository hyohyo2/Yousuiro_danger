class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post.id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  def update
    
  end
  
  def destroy
    
  end

  def timeline
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :post_code, :prefecture_address, :city_address, :block_address, :detail, :status)
  end
  
end
