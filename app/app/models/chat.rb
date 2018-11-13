class Chat < ApplicationRecord
  belongs_to :activity
  belongs_to :application

  enum speaker: {user: 0, circle: 1}
end
