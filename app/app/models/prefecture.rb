class Prefecture < ApplicationRecord
  has_many :cities
  has_many :areas, through: :cities
end
