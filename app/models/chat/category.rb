class Chat::Category < ApplicationRecord
	has_many :chat_rooms, class_name: "Chat::Room",
		dependent: :destroy, foreign_key: :chat_category_id

	validates :name, presence: true, length: { maximum: 32 }
	validates :description, presence: true, length: { maximum: 300 }
end
