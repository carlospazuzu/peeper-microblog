class Status < ApplicationRecord
  validates :body, length: { maximum: 300 }, presence: true
end
