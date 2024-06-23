class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  # チャットルーム一覧
  def index
    @rooms = current_user.rooms
  end
end
