class EventType < ApplicationRecord
  has_many :contents

  validate :name, presence: true
end
