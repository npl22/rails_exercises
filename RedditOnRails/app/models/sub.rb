class Sub < ApplicationRecord
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator, foreign_key: :moderator_id, class_name: 'User'
end
