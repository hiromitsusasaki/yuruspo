class ActivityReview < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validate :evaluation, presence: true
end
