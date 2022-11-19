class Chat::Participant < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room, class_name: "Chat::Room"

  validates :role, inclusion: { in: %w(Admin Normal Reader) }
end
