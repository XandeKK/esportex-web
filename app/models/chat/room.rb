class Chat::Room < ApplicationRecord
  has_many :chat_participants, class_name: "Chat::Participant",
    foreign_key: :chat_room_id, dependent: :destroy
  has_many :chat_messages, class_name: "Chat::Message",
    foreign_key: :chat_room_id, dependent: :destroy
  has_many :chat_tracks, class_name: "Chat::Track",
    foreign_key: :chat_room_id, dependent: :destroy

  belongs_to :chat_category, class_name: "Chat::Category"

  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 500 }
end
