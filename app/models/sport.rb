class Sport < ApplicationRecord
	validates :name, presence: true, length: { maximum: 26 },
		uniqueness: { case_sensitive: false}
	validates :description, length: { maximum: 500 }
end
