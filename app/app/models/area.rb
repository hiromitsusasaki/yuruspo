class Area < ApplicationRecord
  belongs_to :city
  has_many :places
end
