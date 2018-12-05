class CannotReviewByOwnerValidator < ActiveModel::Validator
  def validate(record)
    if record.user == record.activity.circle.owner
      record.errors[:user] << "オーナーはレビューできません"
    end
  end
end

# モデルの定義はここからです。上はValidationについてなので読み飛ばしてください。(本当は下に書きたかったが下に書くと未定義になってしまう)
class ActivityReview < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  include ActiveModel::Validations
  validates_with CannotReviewByOwnerValidator
  validates :evaluation, presence: true
  validates :user, uniqueness: {scope: [:activity]}
end
