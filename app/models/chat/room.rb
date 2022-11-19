class Chat::Room < ApplicationRecord
  belongs_to :chat_category, class_name: "Chat::Category"

  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 500 }
end
