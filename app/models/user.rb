class User < ApplicationRecord
  include Clearance::User

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :normal, resize_to_limit: [500, 500]
  end

  has_many :games, dependent: :destroy
  has_many :game_participants, class_name: "Game::Participant", dependent: :destroy
  has_many :game_comments, class_name: "Game::Comment", dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 80 }
  validates :username, presence: true, length: { maximum: 36 },
    format: { with: /\A[a-zA-Z0-9\-_]+\z/,
      message: "only allows a-z, 0-9, - and _" },
    uniqueness: { case_sensitive: false }
  validates :bio, length: { maximum: 500 }
  validates :avatar, content_type: /\Aimage\/.*\z/,
    size: { less_than: 25.megabytes , message: 'is too large' }
end

