class Game < ApplicationRecord
  after_save :add_organizer_game

  has_many_attached :images_game

  has_many :game_participants, class_name: "Game::Participant", dependent: :destroy
  has_many :game_comments, class_name: "Game::Comment", dependent: :destroy
  
  belongs_to :user
  belongs_to :sport

  validates :address, presence: true
  validates :title, length: { maximum: 100 } 
  validates :info, length: { maximum: 500 } 
  validates :start_date, presence: true, comparison: { less_than: :end_date }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :images_game, content_type: /\Aimage\/.*\z/,
    size: { less_than: 25.megabytes , message: 'is too large' }

  def status timezone
    time = Time.find_zone(timezone)
    
    return :invalid_timezone if time.nil?
    
    return :will_happen if will_happen?(time)
    return :happened if happened?(time)
    return :over if over?(time)
  end

  def join_game user
    # return :full if full?
    if participating?(user)
      :participating
    else
      :successfully_joined if self.game_participants.create!(user: user)
    end
  end

  private

  def will_happen? time
    time.now < self.start_date
  end

  def happened? time
    time.now >= self.start_date && time.now < self.end_date
  end

  def over? time
    time.now > self.end_date
  end

  def participating? user
    self.game_participants.find_by(user: user)
  end

  def add_organizer_game
    join_game self.user
  end

  # def full?
  #   self.game_participants.count == self.maximum
  # end
end