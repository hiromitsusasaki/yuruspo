class Prefecture < ApplicationRecord
  has_many :cities
  has_many :places, through: :cities

  validate :name, presence: true
end
