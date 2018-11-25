class SearchQuery < ApplicationRecord
  belongs_to :user
  belongs_to :contents
  belongs_to :city

  def self.create_with_line_user_id line_user_id
    searching_user = User.find_by(line_user_id: line_user_id)
    return SearchQuery.new(user_id: searching_user.id)
  end

  def self.find_by_line_user_id line_user_id
    searching_user = User.find_by(line_user_id: line_user_id)
    return SearchQuery.find_by(user_id: searching_user.id)
  end

  def self.find_not_completed_query_by_line_user_id line_user_id
    querys = self.find_by_line_user_id line_user_id
  end
end
