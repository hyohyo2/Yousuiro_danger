class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true, length: { maximum: 140 }

  has_one :notification, as: :notifiable, dependent: :destroy

  after_commit :create_notification, on: :create

  private

  # 通知機能(DM)
  def create_notification
    # 送信先のユーザーに通知を作成する
    self.room.users.where.not(id: self.user_id).each do |recipient|
      Notification.create(
        user_id: recipient.id,          # 通知を作成したユーザーのID
        notifiable: self,               # 通知の対象となるオブジェクト（ここではChatインスタンス）
        notifiable_type: 'Chat',        # 通知の対象となるオブジェクトの型
        notifiable_id: self.id          # 通知の対象となるオブジェクトのID
      )
    end
  end

end
