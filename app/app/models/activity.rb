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

end
