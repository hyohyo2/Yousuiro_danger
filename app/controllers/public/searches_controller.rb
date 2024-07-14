class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  # 検索結果一覧
  def search
    @model = params[:model]
    @content = params[:content]

    # 空白で検索すると同じページにリロード
    if @content.blank?
      flash[:alert] = "検索フォームを入力してください。"
      redirect_to request.referer
      return
    end
    # ユーザー検索
    if @model == "user"
      # 投稿住所検索は新着順に表示
      @records = User.search_for(@content).page(params[:page]).per(15)
    # 投稿住所or投稿郵便番号検索
    else
      @records = Post.search_for(@content, @model).page(params[:page]).per(12).order('id DESC')
    end
  end
end
