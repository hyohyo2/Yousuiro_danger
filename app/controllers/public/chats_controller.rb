class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users, only:[:show]
  before_action :ensure_guest_user

  # チャットページ
  def show
    # チャット相手を取得
    @user = User.find(params[:id])
    # ログインユーザーが参加しているチャットルームの一覧を取得
    rooms = current_user.user_rooms.pluck(:room_id)
    # チャットルームの存在の確認
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      # チャットルームがあればチャットルームを表示
      @room = user_rooms.room
    else
      # なければ新しく作成する
      @room = Room.new
      @room.save

      # チャットルームにログインユーザーを追加
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      # 相手ユーザーを追加
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    # チャットのメッセージを取得
    @chats = @room.chats
    # 新しくメッセージを作成
    @chat = Chat.new(room_id: @room.id)

  end
  
  # チャットを送信
  def create
    @chat = current_user.chats.new(chat_params)
    render :validate unless @chat.save
  end
  
  # チャットを削除
  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  # チャット相手以外の利用制限
  def block_non_related_users
    user = User.find(params[:id])
    # 相互フォロー以外はメッセージを表示
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user), alert: "相互フォローでないのでDM機能は利用できません"
    end
  end
  
  # ゲストユーザーの利用制限
  def ensure_guest_user
    if current_user.guest_user
      redirect_to user_path(current_user.id), alert: "ゲストユーザーはDM機能を利用できません"
    end
  end
end
