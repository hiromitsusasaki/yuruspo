class PlaceContent < ApplicationRecord
  belongs_to :place
  belongs_to :content
  has_many :activities
end
