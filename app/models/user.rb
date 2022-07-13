class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :games, dependent: :destroy
  has_many :followers, class_name: "Follower", foreign_key: :follower_id, dependent: :destroy
  has_many :users, class_name: "Follower", foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true, length: { in: 3..20 }
  validates :username, presence: true, uniqueness: true, length: { in: 3..20 } # Colocar regex
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
    message: "only allows letters, number, '-', '+' and '_'", :multiline => true }
  validates :bio, length: { maximum: 300 }
  

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.with(user: self).forgot_password.deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
