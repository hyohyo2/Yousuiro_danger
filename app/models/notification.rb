class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  # DM受信時の
  validates :user_id, presence: true
  validates :notifiable_type, presence: true
  validates :notifiable_id, presence: true
end