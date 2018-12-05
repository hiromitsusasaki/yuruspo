class Circle < ApplicationRecord
  belongs_to :owner, :class_name => 'User'
  has_many :activities
  has_many :applications, through: :activities
  has_many :users, through: :applications
  has_many :user_blocks
  has_many :circle_contents
  has_many :contents, through: :circle_contents

  validates :name, presence: true

  def previous_users
    #やりたいことは circle.applicationsのuseridを全て取ってくる。そしてuseridを一つにする。過去の活動なのでactivityのdateは今日よりも前
    return self.users.select("users.*, activities.date").where("date < ?", Time.zone.today).distinct
  end
end
