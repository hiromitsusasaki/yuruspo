class Activity < ApplicationRecord
  belongs_to :circle
  belongs_to :place_content

  has_many :applications
  has_many :chats
  has_many :activity_reviews
  has_many :messages

  delegate :content, to: :place_content
  delegate :place, to: :place_content

  def self.where_query(search_query)
    # SQL文を条件に応じて作成
    where_str = ""
    where_str = where_str + "content_id = ? AND " unless search_query.content.nil?
    where_str = where_str + "city_id = ? AND " unless search_query.city.nil?
    where_str = where_str + "date = ? AND " unless search_query.date.nil?
    where_str = where_str.chop.chop.chop.chop
    # Whereの配列を作る
    where_arr = [where_str]
    where_arr.push(search_query.content) unless search_query.content.nil?
    where_arr.push(search_query.city) unless search_query.content.nil?
    where_arr.push(search_query.date) unless search_query.date.nil?
    return Activity.joins(place_content: :place).select("activities.id, activities.place_content_id, activities.date, place_contents.*, places.city_id").where(where_arr)
  end

  def self.an_activity_with_query(search_query)
    return self.where_query(search_query).order(:created_at)[search_query.sent_activity_count]#TODO: 将来的にはレビュー順などにしたい
  end

  def self.create_with_query(search_query)
    pl = Place.create(city: search_query.city)
    pc = PlaceContent.create(place: pl, content: search_query.content)
    Activity.create(circle: Circle.find(1), place_content: pc)
  end


  def the_day_before()
    messages = remind_messages
    approved_users().each{|user|
      LineBot::ForUser::PushWorker.perform_async(user.line_user_id, messages)
    }
  end

  def after_activity_at21_oclock()
    # ユーザーへレビューリクエストを送信
    messages_to_user = request_review_messages_to_user
    approved_users().each{|user|
      LineBot::ForUser::PushWorker.perform_async(user.line_user_id, messages_to_user)
    }
    # サークルへレビューリクエストを送信
    messages_to_circle = request_review_messages_to_circle
    LineBot::ForCircle::PushWorker.perform_async(self.circle.owner.line_user_id, messages_to_circle)
  end

  def approved_users
    users = []
    self.applications.where(status: :approved).each{|application|
      users.push application.user
    }
    return users
  end

  private

  def remind_messages
    messages = [
      {
        type: "text",
        text: "明日はこの活動に参加予定だよ！\n忘れないようにね！\nhttps://yurusupo.com/activities/#{self.id}"
      }
    ]
  end


  def request_review_messages_to_user
    messages = [
      {
        type: "text",
        text: "今日の活動はどうだったかな？\n活動について感想を教えてね！\nhttps://yurusupo.com/activities/#{self.id}/review/new"
      }
    ]
  end

  def request_review_messages_to_circle
    messages = [
      {
        type: "text",
        text: "今日の活動はどうでしたか？\n次回参加して欲しくない参加者がいた場合はこちらからブロックができます。\nhttps://yurusupo.com/activities/#{self.id}/bolock"
      }
    ]
  end
end
