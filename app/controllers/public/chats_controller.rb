class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users, only:[:show]
  before_action :ensure_guest_user

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save

      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    @chats = @room.chats

    @chat = Chat.new(room_id: @room.id)

  end

  def create
    @chat = current_user.chats.new(chat_params)

    render :validate unless @chat.save

  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users
    user = User.find(params[:id])

    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user), alert: "相互フォローでないのでDM機能はご利用できません"
    end
  end
  def ensure_guest_user
    if current_user.guest_user
      redirect_to user_path(current_user.id)
    end
  end
end
