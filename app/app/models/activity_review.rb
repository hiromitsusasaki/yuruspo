class ActivityReview < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :evaluation, presence: true
  validates :user, uniqueness: {scope: [:activity]}
end
