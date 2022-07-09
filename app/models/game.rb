class Game < ApplicationRecord
  belongs_to :user
  belongs_to :sport

  validates :localization, presence: true
  validates :address, presence: true
  validates :info, length: { maximum: 300 }
  validates :start_date, presence: true
  validates_comparison_of :end_date, greater_than: :start_date, other_than: Date.today


  scope :sport, ->(sport) { where('sports.name = ? ', sport ) }
  scope :distance_within_10km, ->(lat, lon) { where("ST_DistanceSphere(?, localization::geometry) < 10000", "POINT(#{lon} #{lat})") }
  scope :within_date_end, -> { where("end_date::date >= ?::date", DateTime.current) }

  def is_it_from_the_user?
    self.user_id == Current.user[:id]
  end
end
