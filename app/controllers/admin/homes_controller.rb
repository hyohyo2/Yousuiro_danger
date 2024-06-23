class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  # 投稿一覧
  def top
    @posts = Post.page(params[:page]).per(10).order('id DESC')
  end
end
