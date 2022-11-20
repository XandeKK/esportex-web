class Chat::Room < ApplicationRecord
  before_create :save_token

  has_one_attached :avatar_room do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :normal, resize_to_limit: [500, 500]
  end

  has_one_attached :wallpaper_room

  has_many :chat_participants, class_name: "Chat::Participant",
    foreign_key: :chat_room_id, dependent: :destroy
  has_many :chat_messages, class_name: "Chat::Message",
    foreign_key: :chat_room_id, dependent: :destroy
  has_many :chat_tracks, class_name: "Chat::Track",
    foreign_key: :chat_room_id, dependent: :destroy

  belongs_to :chat_category, class_name: "Chat::Category"

  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 500 }
  validates :token, presence: true, uniqueness: true
  validates :avatar_room, content_type: /\Aimage\/.*\z/,
    size: { less_than: 25.megabytes, message: "is too large" }
  validates :wallpaper_room, content_type: /\Aimage\/.*\z/,
    size: { less_than: 25.megabytes, message: "is too large" }

  def join_room user
    # return :full if full?
    if participating?(user)
      :participating
    else
      :successfully_joined if self.chat_participants.create!(user: user)
    end
  end

  private

  def participating? user
    self.chat_participants.find_by(user: user)
  end

  # def full?
  # end

  def save_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(24, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
