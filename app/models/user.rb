class User < ApplicationRecord
  include Clearance::User

  validates :name, presence: true, length: { maximum: 80 }
  validates :username, presence: true, length: { maximum: 36 },
    format: { with: /\A[a-zA-Z0-9\-!_]+\z/,
      message: "only allows a-z, 0-9, - and _" }, uniqueness: true
  validates :bio, length: { maximum: 500 }
end

