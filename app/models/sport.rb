class Sport < ApplicationRecord
	has_many :games, dependent: :destroy

	has_one_attached :image_sport

	validates :name, presence: true, length: { maximum: 26 },
		uniqueness: { case_sensitive: false}
	validates :description, length: { maximum: 500 }
	validates :image_sport, content_type: /\Aimage\/.*\z/,
    size: { less_than: 3.megabytes , message: 'is too large' }
end
