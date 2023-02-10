class Medium < ApplicationRecord
  validates :kind, presence: true
  belongs_to :status
end
