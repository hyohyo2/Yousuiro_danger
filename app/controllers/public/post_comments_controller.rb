class Public::PostCommentsController < ApplicationController

  # コメント送信
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = post.id
    @comment.save
  end
  
  # コメントを削除
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
