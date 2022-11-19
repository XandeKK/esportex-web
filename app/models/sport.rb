class Sport < ApplicationRecord
	validates :name, presence: true, length: { maximum: 26 }, uniqueness: true
	validates :description, length: { maximum: 500 }
end
