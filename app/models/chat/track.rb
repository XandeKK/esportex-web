class Chat::Track < ApplicationRecord
  belongs_to :chat_room, class_name: "Chat::Room"
  belongs_to :chat_participant, class_name: "Chat::Participant"
end
