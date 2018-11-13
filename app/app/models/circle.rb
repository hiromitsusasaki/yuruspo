class Circle < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :applications, through: :activities
  has_many :user_blocks
  has_many :circle_contents
  has_many :contents, through: :circle_contents
end
