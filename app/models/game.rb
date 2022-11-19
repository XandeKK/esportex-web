class Game < ApplicationRecord
  has_many :game_participants, class_name: "Game::Participant", dependent: :destroy
  has_many :game_comments, class_name: "Game::Comment", dependent: :destroy
  
  belongs_to :user
  belongs_to :sport

  validates :address, presence: true
  validates :title, length: { maximum: 100 } 
  validates :info, length: { maximum: 500 } 
  validates :start_date, presence: true, comparison: { less_than: :end_date }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

end