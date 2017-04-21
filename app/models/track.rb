class Track < ApplicationRecord
  TRACK_TYPES = %w(bonus regular)

  validates :title, presence: true
  validates :album_id, presence: true
  validates :track_type, inclusion: TRACK_TYPES

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band
  has_many :notes, dependent: :destroy
end
