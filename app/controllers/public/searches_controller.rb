class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @current_user = current_user
    @model = params[:model]
    @content = params[:content]
    
    if @model == "user"
      # 投稿住所検索は新着順に表示
      @records = User.search_for(@content).page(params[:page]).per(8)
    else
      @records = Post.search_for(@content).page(params[:page]).per(8).order('id DESC')
    end
    
  end
  
end
