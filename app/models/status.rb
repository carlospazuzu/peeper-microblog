class MediaLimitValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :media, "Max amount of media attached per status is 4" unless record.media.size < 4 
  end
end

class Status < ApplicationRecord
  belongs_to :user
  has_many :replies, class_name: 'Status', foreign_key: 'replied_to_status_id'
  belongs_to :replied_to_status, class_name: 'Status', optional: true
  has_many :media

  validates_with MediaLimitValidator
  validates :body, length: { maximum: 300 }, presence: true
end
