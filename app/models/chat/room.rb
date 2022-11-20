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
end
