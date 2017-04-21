class Album < ApplicationRecord
  ALBUM_TYPES = %w(studio live)

  validates :title, presence: true
  validates :band_id, presence: true
  validates :album_type, inclusion: ALBUM_TYPES

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
