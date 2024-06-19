class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]

    # 空白で検索すると同じページにリロード
    if @content.blank?
      flash[:alert] = "検索フォームを入力してください。"
      redirect_to request.referer
      return
    end

    if @model == "user"
      # 投稿住所検索は新着順に表示
      @records = User.search_for(@content).page(params[:page]).per(8)
    else
      @records = Post.search_for(@content, @model).page(params[:page]).per(8).order('id DESC')
    end

  end

end
