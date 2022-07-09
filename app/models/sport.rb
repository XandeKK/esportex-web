class Sport < ApplicationRecord
  has_one_attached :sport_image
  has_many :games, dependent: :destroy

  validates :name, presence: true
end
