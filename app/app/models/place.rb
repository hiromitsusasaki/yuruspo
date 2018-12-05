class Place < ApplicationRecord
  belongs_to :city
  has_many :place_contents
  has_many :contents, through: :place_contents

  validates :name, presence: true
  validates :address, presence: true
end
