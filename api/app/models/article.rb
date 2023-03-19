class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true
  validates :slug, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
end
