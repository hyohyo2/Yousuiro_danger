class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only:[:index]
  # チャットルーム一覧
  def index
    @rooms = current_user.rooms
  end

  private

  # ゲストログイン時のアクセス制限
  def ensure_guest_user
    if current_user.guest_user
      redirect_to user_path(current_user.id), alert: "ゲストユーザーはご利用できません。"
    end
  end
end
