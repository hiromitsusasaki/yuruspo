class City < ApplicationRecord
  belongs_to :prefecture
  has_many :areas
  has_many :places, through: :areas
end
