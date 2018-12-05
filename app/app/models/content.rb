class Content < ApplicationRecord
  belongs_to :event_type
  has_many :circle_contents
  has_many :circles, through: :circle_contents

  validate :name, presence: true
end
