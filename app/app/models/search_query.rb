class SearchQuery < ApplicationRecord
  belongs_to :user
  belongs_to :content, optional: true
  belongs_to :city, optional: true

  def self.create_with_line_user_id line_user_id
    # sent_activity_countがnullのSearchQueryレコードは一つしか存在してはいけないので、存在する場合消してから作る
    searching_user = User.find_by(line_user_id: line_user_id)
    SearchQuery.where(["user_id = ? and sent_activity_count IS NULL", searching_user]).delete_all
    SearchQuery.create(user: searching_user)
  end

  def self.not_completed_query line_user_id
    return self.where_line_user_id(line_user_id).where("sent_activity_count IS NULL").first
  end

  def self.where_line_user_id line_user_id
    searching_user = User.find_by(line_user_id: line_user_id)
    return SearchQuery.where(["user_id = ?", searching_user.id])
  end

  # プライベートにしておきたい(sent_activity_countがnullのSearchQueryレコードは一つしか存在しない生合成を保つため)
  def create
    super
  end
end
