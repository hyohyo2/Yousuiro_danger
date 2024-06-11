class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def search
    @model = params[:model]
    @content = params[:content]
    
    if @model == "user"
      # 投稿住所検索は新着順に表示
      @records = User.admin_search_for(@content).page(params[:page]).per(8)
    else
      @records = Post.search_for(@content, @model).page(params[:page]).per(8).order('id DESC')
    end
  end
end
