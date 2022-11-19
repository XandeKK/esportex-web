class Chat::Category < ApplicationRecord
	validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 32 }
	validates :description, presence: true, length: { maximum: 300 }
end
