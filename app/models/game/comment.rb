class Game::Comment < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :message, presence: true, length: { maximum: 500 }
end
