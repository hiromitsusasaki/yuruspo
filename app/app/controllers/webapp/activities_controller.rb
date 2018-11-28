class Webapp::ActivitiesController < ApplicationController
  
  def new
    @circle = Circle.find(params[:circle_id])
    @months = months
    @days = days
    @hours = hours
    @minutes = minutes
  end

  def create
    p date_params
    circle = Circle.find(params[:circle_id])
    activity = Activity.new(activity_params)
    activity.circle = circle
    place = Place.find_or_initialize_by(place_params)
    place.city = Prefecture.find_by(name: prefecture_params[:name]).cities.find_by(name: city_params[:name])
    place.save
    content = Content.find(content_params[:id])
    activity.place_content = PlaceContent.find_or_create_by(place: place, content: content)
    date = date(date_params[:month], date_params[:date])
    activity.date = date
    activity.start_time = time(date, start_time_params[:hour], start_time_params[:minute])
    activity.end_time = time(date, end_time_params[:hour], end_time_params[:minute])
    if activity.save
      redirect_to :action => 'show', :circle_id => circle.id, :activity_id => activity.id
    else
      redirect_to :action => 'new', circle_id => circle.id, :flash => {error: '新規活動登録に失敗しました'}
    end
  end

  private

    def activity_params
      params.require('activity').permit(:max_member_number, :should_send_notify, :auto_reply_comment)
    end

    def place_params
      params.require('place').permit(:name, :address, :tel)
    end

    def content_params
      params.require('content').permit(:id)
    end

    def prefecture_params
      params.require('prefecture').permit(:name)
    end

    def city_params
      params.require('city').permit(:name)
    end

    def date_params
      params.require('date').permit(:month, :date)
    end

    def start_time_params
      params.require('start_time').permit(:hour, :minute)
    end

    def end_time_params
      params.require('end_time').permit(:hour, :minute)
    end
  
    def time(date, hour, minute)
      Time.local(date.year, date.month, date.day, hour.to_i, minute.to_i, 0, 0)
    end

    def date(month, date)
      today = Date.today
      date = Date.new(today.year, month.to_i, date.to_i)
      if date < today
        date = date.next_year
      end
      date
    end

    def months 
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    end

    def days
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
      11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
      21, 22, 23, 24, 25, 26, 27, 28, 29, 30 ,31]
    end

    def hours
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    end

    def minutes
      [0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    end

end
