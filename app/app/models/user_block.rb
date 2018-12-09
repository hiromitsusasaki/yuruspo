class UserBlock < ApplicationRecord
  belongs_to :user
  belongs_to :circle

  def self.is_blocking_exists(user, circle)
    !self.find_by(user: user, circle: circle).nil?
  end

end
