class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to request.referer
    else
      flash[:alert] = "コメント投稿に失敗しました。"
      redirect_to request.referer
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    if comment.destroy
     flash[:notice] = "コメントを削除しました。"
      redirect_to request.referer
    else
      flash[:alert] = "コメント削除に失敗しました。"
      redirect_to request.referer
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
