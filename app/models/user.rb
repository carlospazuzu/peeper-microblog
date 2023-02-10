class User < ApplicationRecord
  has_many :follower_follows, foreign_key: 'following_id', class_name: 'Follow'
  has_many :followers, through: :follower_follows

  has_many :following_follows, foreign_key: 'follower_id', class_name: 'Follow'
  has_many :followings, through: :following_follows
  has_many :statuses

  validates :handle, length: { in: 4..12 }, format: { with: /\A\w+\z/ }, uniqueness: true
  validates :display_name, presence: true, length: { maximum: 30 }
  validates :bio, length: { maximum: 300 }
  validates :born_at, comparison: { less_than: Date.today - 13.years }
end
