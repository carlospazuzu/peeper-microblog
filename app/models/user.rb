class User < ApplicationRecord
  validates :handle, length: { in: 4..12 }, format: { with: /\A\w+\z/ }, uniqueness: true
  validates :display_name, presence: true, length: { maximum: 30 }
  validates :bio, length: { maximum: 300 }
  validates :born_at, comparison: { less_than: Date.today - 13.years }
end
