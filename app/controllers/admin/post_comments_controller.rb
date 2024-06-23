class Admin::PostCommentsController < ApplicationController
  # コメントの削除
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
end
